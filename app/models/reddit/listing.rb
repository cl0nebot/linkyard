module Reddit
  class Listing < Response  
    attr_reader :items

    def initialize(data)
      super(data)
      items = extract_value(data, "data/children") || []
      @items = items.map { |data| [Link, Unknown].detect { |i| i.parseable?(data) }.new(data) }
    end

    def self.parseable?(data)
      contains_attribute?(data, "kind") && extract_value(data, "kind") == "Listing"
    end
  end
end
