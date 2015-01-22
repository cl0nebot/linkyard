module Reddit
  class Response
    attr_reader :data

    def initialize(data)
      @data = data
    end

    protected
    def self.contains_attribute?(data, path)
      !extract_value(data, path).nil?
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
end
