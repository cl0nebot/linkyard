module Reddit
  class Identity < Response
    attr_reader :name
    attr_reader :created
    attr_reader :gold_credits
    attr_reader :created_utc
    attr_reader :link_karma
    attr_reader :comment_karma
    attr_reader :over_18
    attr_reader :is_gold
    attr_reader :is_mod
    attr_reader :has_verified_email
    attr_reader :id

    def initialize(data)
      super(data)
      @name = extract_value(data, "name")
      @created = extract_value(data, "created")
      @gold_credits = extract_value(data, "gold_creddits")
      @created_utc = extract_value(data, "created_utc")
      @link_karma = extract_value(data, "link_karma")
      @comment_karma = extract_value(data, "comment_karma")
      @over_18 = extract_value(data, "over_18")
      @is_gold = extract_value(data, "is_gold")
      @is_mod = extract_value(data, "is_mod")
      @has_verified_email = extract_value(data, "has_verified_email")
      @id = extract_value(data, "id")
    end

    def self.parseable?(data)
      contains_attribute?(data, "name") && contains_attribute?(data, "has_verified_email")
    end
  end
end
