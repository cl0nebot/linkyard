module Reddit
  class Link < Response
    attr_reader :url
    attr_reader :author

    def initialize(data)
      super(data)
      @id = extract_value(data, "data/id")
      @url = extract_value(data, "data/url")
      @author = extract_value(data, "data/author")
    end

    def self.parseable?(data)
      contains_attribute?(data, "kind") && extract_value(data, "kind") == 't3'
    end

    def id
      't3_' + @id
    end
  end
end
