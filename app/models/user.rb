class User < ActiveRecord::Base
  has_many :links
  has_many :summaries
  has_many :builders
  has_many :interactions
end
