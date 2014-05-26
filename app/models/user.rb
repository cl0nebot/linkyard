class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:twitter]

  has_many :links, :dependent => :destroy
  has_many :summaries, :dependent => :destroy
  has_many :builders, :dependent => :destroy
  has_many :interactions, :dependent => :destroy
  has_many :authorizations, :dependent => :destroy

  def has_connection_with(provider)
    authorization = authorizations.where(:provider => provider).first
    authorization.present? && authorization.token.present?
  end

  def add_authorization!(authorization_attributes)
    unless authorizations.exists?(:provider => authorization_attributes[:provider])
      authorizations.build(authorization_attributes)
      save!
    end    
  end

  def has_twitter_access?
    twitter_authorizations.any?
  end

  def twitter_authorization
    twitter_authorizations.last if has_twitter_access?
  end

  protected
  def twitter_authorizations
    authorizations.where(:provider => "Twitter")
  end
end
