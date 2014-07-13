module Reddit
  class Submission < Response
    ERROR_CODES = {
      "ALREADY_SUB" => :already_submitted,
      "BAD_CAPTCHA" => :captcha_needed,
      "RATELIMIT" => :rate_limit_exceeded,
      "QUOTA_FILLED" => :quota_filled
    }

    attr_reader :errors
    attr_reader :url
    attr_reader :id
    attr_reader :name

    def initialize(data)
      super(data)

      @url = extract_value(data, "json/data/url")
      @id = extract_value(data, "json/data/id")
      @name = extract_value(data, "json/data/name")
      @errors = extract_value(data, "json/errors").map { |e| ERROR_CODES[e[0]] } || []
    end

    def self.parseable?(data)
      submission_response?(data) || error_response?(data)
    end

    def success?
      @errors.empty?
    end

    def already_submitted?
      errors.include?(:already_submitted)
    end

    private
    def self.submission_response?(data)
      contains_attribute?(data, "json/data/url") && contains_attribute?(data, "json/data/id") && contains_attribute?(data, "json/data/name")
    end

    def self.error_response?(data)
      extract_value(data, "json/errors")
    end
  end
end
