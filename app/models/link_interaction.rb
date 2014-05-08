class LinkInteraction < ActiveRecord::Base
  belongs_to :interaction, :links
end
