class Summary < ActiveRecord::Base
  has_many :link_summaries
  has_many :summary_builders
  belongs_to :user
end
