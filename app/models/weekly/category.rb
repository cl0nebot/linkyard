module Weekly
  class Category
    attr_reader :name, :order, :end_date

    def initialize(name, order, tags, end_date: nil)
      @name = name
      @order = order
      @tags = tags
      @end_date = end_date
    end

    def include?(link_tags)
      link_tags.any? { |tag| @tags.include?(tag) }
    end
  end
end
