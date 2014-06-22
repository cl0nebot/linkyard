class Reddit::Submission < Reddit::Response
  attr_reader :url
  attr_reader :id
  attr_reader :name

  def initialize(data)
    super(data)
    @url = extract_value(data, "json/data/url")
    @id = extract_value(data, "json/data/id")
    @name = extract_value(data, "json/data/name")
  end

  def self.parseable?(data)
    contains_attribute?(data, "json/data/url")
    contains_attribute?(data, "json/data/id")
    contains_attribute?(data, "json/data/name")
  end
end
