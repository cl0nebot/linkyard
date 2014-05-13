class Interaction < ActiveRecord::Base
  belongs_to :user
  has_many :link_interactions, :dependent => :destroy

  validates :type, :presence => true

  def self.new_by_type(type)
    interaction_class = type.constantize
    raise 'Invalid interaction type' unless interaction_class < Interaction
    interaction_class.new
  end


end
