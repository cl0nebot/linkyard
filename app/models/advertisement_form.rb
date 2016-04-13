class AdvertisementForm < MailForm::Base
  attribute :company, :validate => true
  attribute :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :questions
  attribute :url
  attribute :keywords
  attribute :description
  attribute :digest
  attribute :nickname,  :captcha  => true

  def headers
    {
      :subject => "Advertisement request from #{digest} digest",
      :to => "jakub.chodounsky@gmail.com",
      :from => %("#{name}" <#{email}>)
    }
  end

  def pay_per_click
    0.2
  end

  def number_of_subscribers
    @number_of_subscribers ||= Subscriber.active.where(digest: digest).count + RSS_SUBSCRIBERS[digest]
  end

  def average_click_rate
    @average_click_rate ||= begin
      current_digest = Weekly::Digest.issue_from(digest, Time.zone.now)
      sample_size = 3
      clicks = ((current_digest - sample_size)..(current_digest - 1)).flat_map do |issue|
        Weekly::Digest.new(digest, issue: issue).links.map(&:clicks).sort.reverse.take(5)
      end
      average_clicks = clicks.inject { |sum, avg| sum + avg }.to_f / clicks.size
      average_clicks / number_of_subscribers * 100
    end
  end

  def ad_cost_per_issue
    @ad_cost_per_issue ||= pay_per_click * number_of_subscribers * average_click_rate / 100
  end

  def job_listing_cost_per_issue
    ad_cost_per_issue / 3
  end

  private
  RSS_SUBSCRIBERS = {
    "programming" => 165,
    "csharp" => 140,
    "elixir" => 130,
    "react" => 170
  }
end
