class Reddit::Captcha < Reddit::Response
  attr_reader :id

  def initialize(id)
    @id = id
  end
  
  def self.parse_from(json)
    if json["json"] && json["json"]["captcha"] 
      Captcha.new(json["json"]["captcha"].to_i)
    end
  end
end
