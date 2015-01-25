class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:twitter, :reddit]

  has_many :links, dependent: :destroy
  has_many :summaries, dependent: :destroy
  has_many :interactions, dependent: :destroy
  has_many :authorizations, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :summary_builders, dependent: :destroy

  before_save :ensure_authentication_token

  def has_authorization_for?(provider)
    authorizations.where(provider: provider).exists?
  end

  def has_twitter_access?
    twitter_authorization.present?
  end

  def has_reddit_access?
    reddit_authorization.present?
  end

  def twitter_authorization
    authorizations.where(provider: "Twitter").first
  end

  def reddit_authorization
    authorizations.where(provider: "Reddit").first
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
