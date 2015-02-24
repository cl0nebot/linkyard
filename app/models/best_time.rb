class BestTime < ActiveRecord::Base
  def self.for_interaction(interaction)
    order('time ASC')
      .where(interaction: interaction)
      .first
      .time
  end

  def time
    time_from_database = Time.at(super)

    if time_from_database < Time.now
      Chronic.parse("Next #{time_from_database.strftime("%A %-l%P")}")
    else
      time_from_database
    end
  end
end
