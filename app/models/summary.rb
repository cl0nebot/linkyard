class Summary < ActiveRecord::Base
  has_many :links, :through => :link_summaries
  has_many :link_summaries, :dependent => :destroy
  has_many :summary_builders, :dependent => :destroy
  belongs_to :user
end
