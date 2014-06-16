class Reddit::Unknown < Reddit::Response
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def self.parseable?(data)
    true
  end
end
