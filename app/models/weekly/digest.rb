module Weekly
  class Digest
    INITIAL_ISSUE = 92
    INITIAL_ISSUE_FROM = Time.zone.parse("2015-01-26")
    PROGRAMMING = "programming"

    attr_reader :from, :to, :issue

    def self.issue_from(date)
      days_from_initial_issue = (date - INITIAL_ISSUE_FROM) / (3600 * 24)
      ((days_from_initial_issue / 7) + INITIAL_ISSUE - 1).floor
    end

    def self.all
      (INITIAL_ISSUE..issue_from(Time.zone.now)).map { |issue| new(issue: issue) }
    end

    def self.take(number)
      current_issue = issue_from(Time.zone.now)
      ((current_issue - number)..current_issue).map { |issue| new(issue: issue) }
    end

    def self.valid_issue?(number)
      (INITIAL_ISSUE..issue_from(Time.zone.now)).include?(number)
    end

    def initialize(issue: Digest.issue_from(Time.zone.now))
      @issue = issue
      @from = INITIAL_ISSUE_FROM + (7 * (@issue - INITIAL_ISSUE)).days
      @to = (@from + 6.days).end_of_day
    end

    def links
      @links ||= Link.digestable.where(created_at: @from..@to).includes(:tags)
    end

    def links_by_category
      @links_by_category ||= links.group_by { |l| CategoryMatcher.match(l) }
                                  .sort_by { |k, v| k.order }
                                  .to_h
    end
  end
end
