require 'spec_helper'

describe Reddit::Response do
  let(:data) {{ "identity" => { "name" => "Timmy", "surname" => "the Sheep" }}}
  let(:sheep_class) do
    Class.new(Reddit::Response) do
      attr_reader :name
      attr_reader :surname

      def parseable?(data)
        data["identity"].present? && data["identity"]["name"].present?
      end

      def initialize(data)
        @name = extract_value(data, "identity/name")
        @surname = extract_value(data, "identity/surname")
      end
    end
  end

  describe "initialize" do
    it "do something" do
      sheep = sheep_class.new(data)
    end
  end
end

