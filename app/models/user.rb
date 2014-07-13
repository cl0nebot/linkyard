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
      authorizations.build(authorization_attributes)
      save!
    end
  end

  def has_twitter_access?
    twitter_authorization.present?
  end

  def has_reddit_access?
    reddit_authorization.present?
  end

  def twitter_authorization
    authorizations.where(:provider => "Twitter").first
  end

  def reddit_authorization
    authorizations.where(:provider => "Reddit").first
  end
end
