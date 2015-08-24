class Subscriber < ActiveRecord::Base
  include ActiveUUID::UUID

  validates :email,:email_format => { message: 'is not a valid email address' }, uniqueness: { scope: :digest, case_sensitive: false, message: 'is already subscribed' }
  validates :digest, length: { maximum: 20 }, presence: true

  scope :active, -> { where unsubscribed_at: nil }
  scope :for_email, -> { active.where("last_sent_at IS NULL OR last_sent_at < ?", Time.zone.now - 5.days) }
end
