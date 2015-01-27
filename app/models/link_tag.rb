class LinkTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :link
  scope :default, -> { where(default: true) }
end
