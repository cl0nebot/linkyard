class Reddit::Listing < Reddit::Response  
  attr_reader :items

  def initialize(data)
    super(data)
    items = extract_value(data, "data/children") || []
    @items = items.map do |data| 
      [Link, Reddit::Unknown].detect { |c| c.parseable?(data) }.new(data)
    end
  end

  def self.parseable?(data)
    contains_attribute?(data, "kind") && extract_value(data, "kind") == "Listing"
  end
end

