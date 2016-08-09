module Weekly
  class CategoryMatcher

    CONFIGURATION = {
      Weekly::Digest::PROGRAMMING => {
        default: Category.new("programming", 1, []),
        categories: [
          Category.new("sponsor", 0, ["sponsor"]),
          Category.new("ruby", 2, ["ruby", "rails"], end_date: Date.parse('2016-07-31')),
          Category.new("webdev", 3, ["html", "javascript", "webdev", "css"], end_date: Date.parse('2016-07-31')),
          Category.new("fun", 5, ["programmingfun", "funny", "fun"], end_date: Date.parse('2016-07-31')),
          Category.new("jobs", 100, ["job", "jobs"]),
        ]
      },
      Weekly::Digest::CSHARP => {
        default: Category.new(".net", 1, []),
        categories: [
          Category.new("sponsor", 0, ["sponsor"]),
          Category.new("asp.net", 2, ["aspnet", "iis"], end_date: Date.parse('2016-07-31')),
          Category.new("azure", 3, ["azure"], end_date: Date.parse('2016-07-31')),
          Category.new("wpf", 4, ["wpf"], end_date: Date.parse('2016-07-31')),
          Category.new("jobs", 100, ["job", "jobs"]),
        ]
      },
      Weekly::Digest::ELIXIR => {
        default: Category.new("elixir", 1, []),
        categories: [
          Category.new("sponsor", 0, ["sponsor"]),
          Category.new("phoenix", 2, ["phoenix"], end_date: Date.parse('2016-07-31')),
          Category.new("jobs", 100, ["job", "jobs"]),
        ]
      },
      Weekly::Digest::REACT => {
        default: Category.new("react", 1, []),
        categories: [
          Category.new("sponsor", 0, ["sponsor"]),
          Category.new("react native", 2, ["reactnative"], end_date: Date.parse('2016-07-31')),
          Category.new("jobs", 100, ["job", "jobs"]),
        ]
      }
    }

    def self.match(type, link)
      CONFIGURATION[type][:categories].find { |c| c.include?(link.tags.map { |t| t.name }) && (c.end_date.nil? || link.created_at <= c.end_date) } || CONFIGURATION[type][:default]
    end
  end
end
