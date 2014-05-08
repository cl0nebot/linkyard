class LinkInteraction < ActiveRecord::Base
  belongs_to :interaction 
  belongs_to :link
end
