class Reddit::Listing < Reddit::Response  
  attr_reader :items

  def initialize(data)
    super(data)
    items = extract_value(data, "data/children") || []
    @items = items.map { |data| self.class.new_from_data(data, [Link, Reddit::Unknown]) }
  end

  def self.parseable?(data)
    contains_attribute?(data, "kind") && extract_value(data, "kind") == "Listing"
  end
end

