class Reddit::Response
  attr_reader :data

  def initialize(data)
    @data = data
  end

  protected
  def extract_value(data, path)
    self.class.extract_value(data, path)
  end 


  def self.contains_attribute?(data, path)
    !self.extract_value(data, path).nil?
  end

  private
  def self.extract_value(data, path)
    path.split("/").inject(data) do |hash, element|
      hash[element] if hash
    end
  end
end
