class SummaryBuilder < ActiveRecord::Base
  belongs_to :summary, :builder
end
