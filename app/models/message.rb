class Message < ActiveRecord::Base
  belongs_to :user
  validates :content, presence: true
  validates :digest, inclusion: { in: Weekly::Digest::TYPES }

  scope :digestable, -> (digest) { order(created_at: :asc).where(user_id: 7, digest: digest) }
end
