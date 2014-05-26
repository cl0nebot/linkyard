class OauthLogin

  ACCOUNT_LINKED = :account_linked
  SIGNED_IN = :signed_in
  SIGNED_UP = :signed_up

  attr_reader :user

  def initialize(current_user, access_token)
    @user = current_user
    @authorization_attributes = initialize_authorization_attributes(access_token)
  end

  def run!
    if @user
      @user.add_authorization!(@authorization_attributes)
      ACCOUNT_LINKED
    elsif auth = Authorization.find_by_uid(@authorization_attributes[:uid].to_s)
      @user = auth.user
      SIGNED_IN
    else
      @user = User.create!(:password => Devise.friendly_token[0,20], :email => extract_email)
      @user.add_authorization!(@authorization_attributes)
      SIGNED_UP
    end
  end

  def name 
    raise "Abstract method should be overriden"  
  end

  protected
  def extract_email
    @authorization_attributes.email || "#{UUIDTools::UUID.random_create}@l.me"
  end

  def initialize_authorization_attributes(access_token)
    raise "Abstract method should be overriden" 
  end
end

