module Reddit
  class Unknown < Response
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def self.parseable?(data)
      true
    end
  end
end
