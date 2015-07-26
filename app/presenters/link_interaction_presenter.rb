class LinkInteractionPresenter < SimpleDelegator
  def to_s
    "#{interaction.class.humanized_name} (#{status_and_best_scheduled_time})"
  end

  private

  def status_and_best_scheduled_time
    [
      status,
      best_scheduled_time
    ].join(', ')
  end

  def best_scheduled_time
    "scheduled at #{format(super)}" if super.present?
  end

  def format(time)
    time.strftime("%A #{time.day.ordinalize} %b %-l%P")
  end
end
