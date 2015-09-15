module Weekly
  class CategoryMatcher

    CONFIGURATION = {
      Weekly::Digest::PROGRAMMING => {
        default: Category.new("general", 1, []),
        categories: [
          Category.new("ruby", 2, ["ruby", "rails"]),
          Category.new("webdev", 3, ["html", "javascript", "webdev", "css"]),
          Category.new("fun", 5, ["programmingfun", "funny"]),
          Category.new("sponsor", 0, ["sponsor"])
        ]
      },
      Weekly::Digest::PHOTOGRAPHY => {
        default: Category.new("general", 1, []),
        categories: [
          Category.new("photos of the week", 2, ["photo"]),
          Category.new("tutorials", 3, ["tutorial"]),
          Category.new("gear reviews", 4, ["gear"]),
          Category.new("sponsor", 0, ["sponsor"])
        ]
      },
      Weekly::Digest::CSHARP => {
        default: Category.new(".net", 1, []),
        categories: [
          Category.new("asp.net", 2, ["aspnet", "iis"]),
          Category.new("azure", 3, ["azure"]),
          Category.new("wpf", 4, ["wpf"]),
          Category.new("sponsor", 0, ["sponsor"])
        ]
      },
      Weekly::Digest::ELIXIR => {
        default: Category.new("elixir", 1, []),
        categories: [
          Category.new("phoenix", 2, ["phoenix"]),
          Category.new("sponsor", 0, ["sponsor"])
        ]
      },
      Weekly::Digest::REACT => {
        default: Category.new("react", 1, []),
        categories: [
          Category.new("sponsor", 0, ["sponsor"]),
          Category.new("react native", 2, ["reactnative"])
        ]
      }
    }

    def self.match(type, link)
      CONFIGURATION[type][:categories].find { |c| c.include?(link.tags.map { |t| t.name }) } || CONFIGURATION[type][:default]
    end
  end
end
