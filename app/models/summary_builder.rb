class SummaryBuilder < ActiveRecord::Base
  belongs_to :summary 
  belongs_to :builder
end
