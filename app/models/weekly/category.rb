module Weekly
  class Category
    attr_reader :name, :order

    def initialize(name, order, tags)
      @name = name
      @order = order
      @tags = tags
    end

    def include?(link_tags)
      link_tags.any? { |tag| @tags.include?(tag) }
    end
  end
end
