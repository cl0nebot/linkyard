class Link < ActiveRecord::Base
  has_many :summaries, :through => :link_summaries
  has_many :link_interactions, :dependent => :destroy
  belongs_to :user

  validates :title, :presence => true
  validates :url, :format => { :with => URI::regexp(%w(http https)), :message => "should be a valid address"}

  def save_and_publish
    link_interactions.each { |li| InteractionWorker.perform_async(li.id) } if save
  end
end
