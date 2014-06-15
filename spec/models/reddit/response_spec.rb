require 'spec_helper'

describe Reddit::Response do
  let(:json) {{ "identity" => { "name" => "Timmy", "surname" => "the Sheep" }}}
  let(:sheep_class) do Class.new(Reddit::Response) do
      reddit_reader [:name, "identity/name"]
      reddit_reader [:surname, "identity/surname"]
    end
  end

  describe "initialize" do
    it "do something" do
      sheep = sheep_class.parse_from(json)
      puts sheep.name + " " + sheep.surname 
    end
  end
end

