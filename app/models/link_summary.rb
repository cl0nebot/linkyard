class LinkSummary < ActiveRecord::Base
  belongs_to :link
  belongs_to :summary
end
