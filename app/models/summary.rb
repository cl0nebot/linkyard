class Summary < ActiveRecord::Base
  has_many :links, through: :link_summaries
  has_many :link_summaries, dependent: :destroy
  belongs_to :summary_builder
  belongs_to :user

  def available_builders
  end
end
