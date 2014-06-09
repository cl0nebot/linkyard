class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:twitter, :reddit]

  has_many :links, :dependent => :destroy
  has_many :summaries, :dependent => :destroy
  has_many :builders, :dependent => :destroy
  has_many :interactions, :dependent => :destroy
  has_many :authorizations, :dependent => :destroy

  def has_authorization_for?(provider)
    authorizations.where(:provider => provider).exists?
  end

  def add_authorization!(authorization_attributes)
    unless authorizations.exists?(:provider => authorization_attributes[:provider])
      byebug
      authorizations.build(authorization_attributes)
      save!
    end    
  end

  def has_twitter_access?
    twitter_authorizations.exists?
  end

  def twitter_authorization
    twitter_authorizations.last
  end

  protected
  def twitter_authorizations
    authorizations.where(:provider => "Twitter")
  end
end
