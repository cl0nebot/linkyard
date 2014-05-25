require 'spec_helper'

describe Interaction do
  let(:twitter_interaction_name) { "Twitter" }
  let(:reddit_interaction_name) { "Reddit" }
  let(:twitter_interaction_type) { "TwitterInteraction" }
  let(:reddit_interaction_type) { "RedditInteraction" }

  def new_by_type(type)
    Interaction.new_by_type(type)
  end 

  describe ".new_by_type" do
     
    context "when creating twitter interaction" do
      subject { new_by_type(twitter_interaction_type) }
      it { should be_instance_of TwitterInteraction }
    end
  
    context "when creating reddit interaction" do     
      subject { new_by_type(reddit_interaction_type) }
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
      subject { humanize_type(twitter_interaction_type) }
      it { should match twitter_interaction_name }
    end

    context "when reddit interaction is passed" do
      subject { humanize_type(reddit_interaction_type) }
      it { should match reddit_interaction_name }
    end
  end

  describe "#act" do
    it "raises as it is an abstract method" do
      expect { Interaction.new.act }.to raise_error
    end
  end

  describe "#name" do
    it "should return reasonable name for existing interactions" do
      new_by_type(twitter_interaction_type).name.should match twitter_interaction_name
      new_by_type(reddit_interaction_type).name.should match reddit_interaction_name
    end
  end

end
