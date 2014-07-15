class Tag < ActiveRecord::Base
  has_many :link_tags, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }
end
