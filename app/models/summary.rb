class Summary < ActiveRecord::Base
  has_and_belongs_to_many :links
  has_many :summary_builders
  belongs_to :user
end
