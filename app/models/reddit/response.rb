class Reddit::Response
  class << self
    def reddit_reader(*args)
      args.each do |attribute|
        reddit_attributes << attribute
        attr_reader attribute[0]
      end
    end
  end

  def self.reddit_attributes
    @@attributes ||= []
  end

  def self.parse_from(json)
    values = {}
    @@attributes.each do |attribute|
      path = attribute[1].split("/")
      value = value_for(path, json)
      return nil if value.nil?
      values[attribute[0]] = value
    end

    new(values)
  end

  def initialize(values = {})
    values.each do |key, value| 
      instance_variable_set("@" + key.to_s, value)
    end
  end

  private
  def self.value_for(path, object)
    return nil if object.nil?
    return object unless path.present?

    current_path = path.shift
    value_for(path, object[current_path])
  end
end
