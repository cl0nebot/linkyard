class LinkInteractionPresenter < SimpleDelegator
  TIME_FORMAT = '%A %-d %b %-l%P'
  def to_s
    "#{interaction.class.humanized_name} (#{status_and_scheduled_time})"
  end

  private

  def status_and_scheduled_time
    [
      status,
      scheduled_time_text
    ].join(', ')
  end

  def scheduled_time_text
    "scheduled at #{format(scheduled_time)}" if scheduled_time.present?
  end

  def format(time)
    time.strftime("%A #{time.day.ordinalize} %b %-l%P")
  end
end
