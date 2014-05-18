class Interaction < ActiveRecord::Base
  belongs_to :user
  has_many :link_interactions, :dependent => :destroy

  validates :type, :presence => true
  store :configuration, :accessors => [], :coder => JSON

  AVAILABLE_INTERACTIONS = %w(TwitterInteraction RedditInteraction)

  def self.new_by_type(type, attributes = {})
    interaction_class = AVAILABLE_INTERACTIONS.detect { |name| name == type }
    raise 'Invalid interaction type' unless interaction_class.present?
    interaction_class.constantize.new(attributes)
  end
  
  def self.humanize_type(type)
    type.gsub('Interaction', '').underscore.humanize  
  end


  def name
    self.class.humanize_type(type)
  end

  def act(link)
    raise 'Abstract method should be overriden on descendants.'
  end
end
