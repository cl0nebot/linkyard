class Authorization < ActiveRecord::Base
  belongs_to :user

  validates :digest, inclusion: { in: Weekly::Digest::TYPES, allow_nil: true }
end
