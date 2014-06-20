class Reddit::Captcha < Reddit::Response
  attr_reader :id

  def initialize(data)
    @id = extract_value(data, "json/captcha")
  end
  
  def self.parseable?(data)
    contains_attribute?(data, "json/captcha")
  end
end
