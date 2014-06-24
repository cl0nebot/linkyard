class Reddit::Link < Reddit::Response  
  attr_reader :id
  attr_reader :url
  attr_reader :author

  def initialize(data)
    super(data)
    @id = extract_value(data, "data/id")
    @url = extract_value(data, "data/author")
    @author = extract_value(data, "data/author")
  end

  def self.parseable?(data)
    contains_attribute?(data, "kind") && extract_value(data, "kind") == 't3'
  end

  def fullname
    't3_' + @id
  end
end
