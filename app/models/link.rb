class Link < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:title, :url, :content, :description]

  has_many :link_interactions, dependent: :destroy
  has_many :link_tags, dependent: :destroy
  has_many :tags, through: :link_tags
  has_many :share_requests
  belongs_to :user

  before_validation :normalize

  validates :title, length: { maximum: 120 }, presence: true
  validates :url, length: { maximum: 200 }, format: { with: URI::regexp(%w(http https)), message: "should be a valid address" }
  validates :digest, inclusion: { in: Weekly::Digest::TYPES, allow_nil: true }

  scope :digestable, -> (digest) { order(description: :desc, created_at: :asc).where(user_id: 7, digest: digest) }

  def self.for_digest
    Time.use_zone("Wellington") do
      Chronic.time_class = Time.zone
      last_sunday = Chronic.parse('sunday', :context => :past).end_of_day
      last_monday = (last_sunday - 6.days).beginning_of_day
      Link.where(created_at: last_monday..last_sunday)
    end
  end

  def save_and_publish
    save.tap do |save_succeeded|
      link_interactions.each { |li| li.perform_or_schedule! if save_succeeded }
    end
  end

  def default_tag
    link_tags.default.present? ? link_tags.default.first.tag : nil
  end

  def decorated_url(medium)
    add_params(url, { utm_source: "#{digest}digest", utm_medium: medium || "email", utm_campaign: sponsored? ? "sponsored" : "featured" })
  end

  def sponsored?
    tags.map(&:name).include?("sponsor")
  end

  def weekly_digest
    Weekly::Digest.new(digest, issue: Weekly::Digest.issue_from(digest, created_at) + 1)
  end

  protected
  def normalize
    self.url = "http://#{url}" unless url.blank? || url.start_with?("http")
    self.digest = nil unless Weekly::Digest::TYPES.include?(digest)
  end

  def add_params(url, params)
    uri = URI(url)
    query_params = URI.decode_www_form(uri.query || "")
    original_keys = query_params.map { |k, v| k.to_sym }
    params.each { |name, value| query_params << [name, value] unless original_keys.include?(name) }
    uri.query = URI.encode_www_form(query_params)
    uri.to_s
  end
end
