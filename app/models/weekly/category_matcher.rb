module Weekly
  class CategoryMatcher
    DEFAULT_CATEGORY = Category.new("general", 1, [])
    CATEGORIES = [
      Category.new("ruby", 2, ["ruby", "rails"]),
      Category.new("webdev", 3, ["html", "javascript", "webdev", "css"]),
      Category.new("csharp", 4, ["csharp", "net", "microsoft", "windows"]),
      Category.new("fun", 5, ["programmingfun", "funny"])
    ]

    def self.match(link)
      CATEGORIES.find { |c| c.include?(link.tags.map { |t| t.name }) } || DEFAULT_CATEGORY
    end
  end
end
