class Reddit::Error < Reddit::Response  
  ERRORS_MAP = { 
    "ALREADY_SUB" => -> (data) { AlreadySubmittedError.new },
    "BAD_CAPTCHA" => -> (data) { CaptchaError.new(extract_value(data, "json/captcha")) },
    "RATELIMIT" => -> (data) { RateLimitError.new(extract_value(data, "json/ratelimit")) },
    "QUOTA_FILLED" => -> (data) { QuotaFilledError.new },
  }

  attr_reader :errors

  def initialize(data)
    super(data)
    @errors = extract_value(data, "json/errors").map { |error| (ERRORS_MAP[error[0]] || -> (data) { error }).call(data) }
  end

  def self.parseable?(data)
    contains_attribute?(data, "json/errors") && extract_value(data, "json/errors").present?
  end
end
