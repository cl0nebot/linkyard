module Weekly
  class CategoryMatcher

    CONFIGURATION = {
      Weekly::Digest::PROGRAMMING => {
        default: Category.new("general", 1, []),
        categories: [
          Category.new("ruby", 2, ["ruby", "rails"]),
          Category.new("webdev", 3, ["html", "javascript", "webdev", "css"]),
          Category.new("csharp", 4, ["csharp", "net", "microsoft", "windows"]),
          Category.new("fun", 5, ["programmingfun", "funny"])
        ]
      },
      Weekly::Digest::PHOTOGRAPHY => {
        default: Category.new("general", 1, []),
        categories: [
          Category.new("photos of the week", 2, ["photo"]),
          Category.new("tutorials", 3, ["tutorial"]),
          Category.new("gear reviews", 4, ["gear"]),
        ]
      }
    }

    def self.match(type, link)
      CONFIGURATION[type][:categories].find { |c| c.include?(link.tags.map { |t| t.name }) } || CONFIGURATION[type][:default]
    end
  end
end
