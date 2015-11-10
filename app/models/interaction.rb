class Interaction < ActiveRecord::Base
  belongs_to :user
  has_many :link_interactions, dependent: :destroy

  validates :type, presence: true
  store :configuration, accessors: [], coder: JSON


  def self.new_by_name(name, attributes = {})
    raise 'Invalid interaction type' unless AVAILABLE_INTERACTIONS.include?(name)
    name.constantize.new(attributes)
  end

  def self.prepare_parameters_by_name(name, params = {})
    raise 'Invalid interaction type' unless AVAILABLE_INTERACTIONS.include?(name)
    name.constantize.prepare(params.clone)
  end

  def self.available_interactions
    AVAILABLE_INTERACTIONS.map { |i| i.constantize }
  end

  def self.humanized_name
    name.gsub("Interaction", "").underscore.humanize
  end

  def self.atomic?
    true
  end

  def self.prepare(attributes)
    attributes
  end

  def act(link_interaction)
    raise 'Abstract method should be overriden on descendants.'
  end

  def best_time_to_post
    BestTime.for_interaction(type)
  end

  private
  AVAILABLE_INTERACTIONS = %w(TwitterInteraction RedditInteraction ScheduledInteraction CompositeInteraction, BufferInteraction)
  AVAILABLE_INTERACTIONS << 'DummyInteraction' if ['development', 'test'].include? Rails.env
end
