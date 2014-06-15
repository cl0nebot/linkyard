class Reddit::Unknown < Reddit::Response
  attr_reader :json

  def initialize(json)
    @json = json
  end
end
