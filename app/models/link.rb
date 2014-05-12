class Link < ActiveRecord::Base
  has_many :summaries, :through => :link_summaries
  has_many :link_interactions
  belongs_to :user

  validates :title, :url, :presence => true
  validates :url, :format => { :with => URI::regexp(%w(http https)), :message => "should be a valid address"}
end
