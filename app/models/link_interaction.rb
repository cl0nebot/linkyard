class LinkInteraction < ActiveRecord::Base
  belongs_to :interaction 
  belongs_to :link

  def act
    interaction.act(link)
  end
end
