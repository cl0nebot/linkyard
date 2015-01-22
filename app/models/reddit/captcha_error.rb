class Reddit::CaptchaError
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def self.parseable?(data)
    contains_attribute?(data, "json/captcha")
  end
end
