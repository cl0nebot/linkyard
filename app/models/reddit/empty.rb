module Reddit
  class Empty < Response
    def initialize(data)
      super(data)
    end

    def self.parseable?(data)
      data.empty?
    end
  end
end
