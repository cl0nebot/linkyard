class SummaryBuilder < ActiveRecord::Base
  belongs_to :user
  has_many :summaries, dependent: :nullify

  def name
    type.underscore.humanize
  end
end
