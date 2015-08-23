module Weekly
  class Digest
    PHOTOGRAPHY = "photography"
    PROGRAMMING = "programming"
    CSHARP = "csharp"
    ELIXIR = "elixir"
    REACT = "react"
    TYPES = [PROGRAMMING, PHOTOGRAPHY, CSHARP, ELIXIR, REACT]
    CONFIGURATION = {
      PROGRAMMING => { initial_issue: 92, from: Time.zone.parse("2015-01-26") },
      PHOTOGRAPHY => { initial_issue: 1, from: Time.zone.parse("2015-08-10") },
      CSHARP => { initial_issue: 35, from: Time.zone.parse("2015-01-26") },
      ELIXIR => { initial_issue: 8, from: Time.zone.parse("2015-08-17") },
      REACT => { initial_issue: 5, from: Time.zone.parse("2015-08-17") }
    }

    attr_reader :from, :to, :issue, :type

    def self.current_digest(type)
      self.new(type, issue: self.issue_from(type, Time.zone.now))
    end

    def self.issue_from(type, date)
      days_from_initial_issue = (date - CONFIGURATION[type][:from]) / (3600 * 24)
      ((days_from_initial_issue / 7) + CONFIGURATION[type][:initial_issue] - 1).floor
    end

    def self.all(type)
      (CONFIGURATION[type][:initial_issue]..issue_from(type, Time.zone.now)).map { |issue| new(type, issue: issue) }
    end

    def self.take(type, number)
      current_issue = issue_from(type, Time.zone.now)
      ([(current_issue - number), CONFIGURATION[type][:initial_issue]].max..current_issue).map { |issue| new(type, issue: issue) }
    end

    def self.valid_issue?(type, number)
      (CONFIGURATION[type][:initial_issue]..issue_from(type, Time.zone.now)).include?(number)
    end

    def initialize(type, issue: Digest.issue_from(Time.zone.now))
      @issue = issue
      @from = CONFIGURATION[type][:from] + (7 * (@issue - CONFIGURATION[type][:initial_issue])).days
      @to = (@from + 6.days).end_of_day
      @type = type
    end

    def links
      @links ||= Link.digestable(type).where(created_at: @from..@to).includes(:tags)
    end

    def domain
      "#{type}digest.net"
    end

    def links_by_category
      @links_by_category ||= links.group_by { |l| CategoryMatcher.match(type, l) }
                                  .sort_by { |k, v| k.order }
                                  .to_h
    end
  end
end
