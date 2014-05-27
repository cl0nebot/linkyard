module OauthLogin
  def self.included(base)
    base.extend ClassMethods
    base.cattr_accessor :attributes_proc
  end

  module ClassMethods
    def configure_oauth_login(&block)
      self.attributes_proc = block
    end
  end

  ACCOUNT_LINKED = :account_linked
  SIGNED_IN = :signed_in
  SIGNED_UP = :signed_up

  attr_reader :user

  def initialize(current_user, access_token)
    @user = current_user
    @authorization_attributes = self.class.attributes_proc.call(access_token)
  end

  def run!
    if @user
      @user.add_authorization!(@authorization_attributes)
      ACCOUNT_LINKED
    elsif auth = Authorization.find_by_uid(@authorization_attributes[:uid].to_s)
      @user = auth.user
      SIGNED_IN
    else
      @user = User.create!(:password => Devise.friendly_token[0,20], :email => "#{UUIDTools::UUID.random_create}@l.me")
      @user.add_authorization!(@authorization_attributes)
      SIGNED_UP
    end
  end
end

