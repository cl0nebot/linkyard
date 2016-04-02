class Tag < ActiveRecord::Base
  has_many :link_tags, dependent: :destroy
  has_many :links, through: :link_tags
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }
end
