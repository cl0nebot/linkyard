require 'spec_helper'

describe Interaction do
  
  describe ".new_by_type" do

    def new_by_type(type)
      Interaction.new_by_type(type)
    end 
     
    context "when creating twitter interaction" do
      subject { new_by_type("TwitterInteraction") }
      it { should be_instance_of TwitterInteraction }
    end
  
    context "when creating reddit interaction" do     
      subject { new_by_type("RedditInteraction") }
      it { should be_instance_of RedditInteraction }
    end

    it "when creating invalid interaction" do
      expect { new_by_type("NotSupportedInteraction") }.to raise_error
    end
  end
  
  describe ".humanize_type" do
    def humanize_type(type)
      Interaction.humanize_type(type)
    end

    context "when twitter interaction is passed" do
      subject { humanize_type("TwitterInteraction") }
      it { should match "Twitter"}
    end

    context "when reddit interaction is passed" do
      subject { humanize_type("RedditInteraction") }
      it { should match "Reddit" }
    end
  end

  describe "#act" do
    it "raises as it is an abstract method" do
      expect { Interaction.new.act }.to raise_error
    end
  end

end
