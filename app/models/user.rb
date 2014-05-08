class User < ActiveRecord::Base
  has_many :links, :summaries, :builders, :interactions
end
