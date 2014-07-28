class SummaryBuilder < ActiveRecord::Base
  belongs_to :user
  has_many :summaries, dependent: :null
end
