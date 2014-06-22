class Reddit::RateLimitError
  attr_reader :rate_limit

  def initialize(rate_limit)
    @rate_limit = rate_limit
  end
end
