class LinkInteraction < ActiveRecord::Base
  belongs_to :interaction
  belongs_to :link

  def act
    interaction.act(self)
  end

  def update_and_notify!(status, description)
    update!(:status => status, :status_description => description)
    # notify some notification mechanism like nodejs or whatever
  end
end
