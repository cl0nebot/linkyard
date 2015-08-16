class Subscriber < ActiveRecord::Base
  include ActiveUUID::UUID

  validates :email,:email_format => { message: 'is not a valid email address' }, uniqueness: { case_sensitive: false, message: 'is already subscribed' }
  validates :digest, length: { maximum: 20 }, presence: true

  scope :active, -> { where unsubscribed_at: nil }
end