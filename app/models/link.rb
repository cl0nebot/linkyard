class Link < ActiveRecord::Base
  #has_many :link_summaries, :dependent => :destroy
  #has_many :summaries, :through => :link_summaries
  has_many :link_interactions, dependent: :destroy
  has_many :link_tags, dependent: :destroy
  has_many :tags, through: :link_tags
  belongs_to :user

  before_validation :normalize_url

  validates :title, length: { maximum: 100 }, presence: true
  validates :url, length: { maximum: 100 }, format: { with: URI::regexp(%w(http https)), message: "should be a valid address" }

  def save_and_publish
    save.tap do |save_succeeded|
      link_interactions.each { |li| InteractionWorker.perform_async(li.id) if save_succeeded }
    end
  end

  protected
  def normalize_url
    self.url = "http://#{url}" unless url.blank? || url.start_with?("http")
  end
end
