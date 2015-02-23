class BestTime < ActiveRecord::Base
  def self.for_interaction(interaction)
    order('time ASC')
      .where(interaction: interaction)
      .first
      .time
  end

  def time
    Time.at(super)
  end
end
