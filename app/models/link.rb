class Link < ActiveRecord::Base
  has_and_belongs_to_many :summaries
  has_many :link_interactions
  belongs_to :user
end
