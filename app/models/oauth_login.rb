class OauthLogin

  ACCOUNT_LINKED = :account_linked
  SIGNED_IN = :signed_in
  SIGNED_UP = :signed_up

  attr_reader :user

  def initialize(user, access_token)
    @user = user
    @access_token = access_token
  end

  def run!
    if @user
      CreateAuthorization.new(@user, authorization_attributes).call
      ACCOUNT_LINKED
    elsif auth = Authorization.find_by_uid(authorization_attributes[:uid].to_s)
      @user = auth.user
      SIGNED_IN
    else
      @user = User.create!(:password => Devise.friendly_token[0,20], :email => "#{UUIDTools::UUID.random_create}@l.me")
      CreateAuthorization.new(@user, authorization_attributes).call
      SIGNED_UP
    end
  end

  def authorization_attributes
    @authorization_attributes ||= parse_attributes(@access_token)
  end

  def name
    raise 'Abstract method should be overriden by subclass'
  end

  protected
  def parse_attributes
    raise 'Abstract method should be overriden by subclass'
  end
end

