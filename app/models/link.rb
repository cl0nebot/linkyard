class Link < ActiveRecord::Base
  has_many :summaries, :through => :link_summaries
  has_many :link_interactions
  belongs_to :user

  validate :title, :url, :presence => true
  validate :url, :format => { :with => URI::regexp(%w(http https)), :message => "Your link should be a valid URL"}
end
