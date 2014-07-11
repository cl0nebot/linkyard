class Interaction < ActiveRecord::Base
  belongs_to :user
  has_many :link_interactions, :dependent => :destroy

  validates :type, :presence => true
  store :configuration, :accessors => [], :coder => JSON

  AVAILABLE_INTERACTIONS = %w(TwitterInteraction RedditInteraction)

  def self.new_by_type(type, attributes = {})
    raise 'Invalid interaction type' unless AVAILABLE_INTERACTIONS.include?(type)
    type.constantize.new(attributes)
  end

  def self.humanize_type(type)
    type.gsub('Interaction', '').underscore.humanize
  end

  def name
    self.class.humanize_type(type)
  end

  def act(link_interaction)
    raise 'Abstract method should be overriden on descendants.'
  end
end
