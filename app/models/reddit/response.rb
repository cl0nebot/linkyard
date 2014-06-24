class Reddit::Response
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def self.new_from(json, available_responses)
    self.new_from_data(JSON.parse(json), [Error, available_responses, Unknown].flatten)
  end

  def self.new_from_data(data, available_responses)
    available_responses.detect { |i| i.parseable?(data) }.new(data)
  end
    
  protected
  def self.contains_attribute?(data, path)
    !self.extract_value(data, path).nil?
  end

  def extract_value(data, path)
    self.class.extract_value(data, path)
  end 

  private
  def self.extract_value(data, path)
    path.split("/").inject(data) do |hash, element|
      hash[element] if hash
    end
  end
end
