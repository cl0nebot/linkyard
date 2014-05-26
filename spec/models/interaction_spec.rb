require 'spec_helper'

describe Interaction do
  let(:twitter_interaction_name) { "Twitter" }
  let(:reddit_interaction_name) { "Reddit" }
  let(:twitter_interaction_type) { "TwitterInteraction" }
  let(:reddit_interaction_type) { "RedditInteraction" }

  describe "validations" do
    describe "on type" do 
      context "when type isn't present" do
        it "should be invalid" do
          expect(Interaction.new).to have_at_least(1).error_on(:type)
        end
      end

      context "when using subclass" do
        it "should be valid" do
          expect(RedditInteraction.new).to have(0).error_on(:type)
        end
      end
    end
  end

  describe ".new_by_type" do
    subject { Interaction.new_by_type(type) }

    context "when creating twitter interaction" do
      let(:type) { twitter_interaction_type }
      it { should be_instance_of TwitterInteraction }
    end
  
    context "when creating reddit interaction" do 
      let(:type) { reddit_interaction_type }
      it { should be_instance_of RedditInteraction }
    end

    context "when creating invalid interaction" do
      let(:type) { "NotSupportedInteraction" }
      it "raise error" do 
        expect { Interaction.new_by_type(type) }.to raise_error
      end
    end
  end

  describe ".humanize_type" do    
    subject { Interaction.humanize_type(type) }

    context "when twitter interaction is passed" do
      let(:type) { twitter_interaction_type }
      it { should match twitter_interaction_name }
    end

    context "when reddit interaction is passed" do
      let(:type) { reddit_interaction_type }
      it { should match reddit_interaction_name }
    end
  end

  describe "#act" do
    it "raises as it is an abstract method" do
      expect { Interaction.new.act }.to raise_error
    end
  end

  describe "#name" do
    subject { Interaction.new_by_type(type).name }

    context "when twitter interaction is passed" do
      let(:type) { twitter_interaction_type }
      it { should match twitter_interaction_name }
    end

    context "when reddit interaction is passed" do
      let(:type) { reddit_interaction_type }
      it { should match reddit_interaction_name }
    end
  end
end
