require 'rails_helper'

describe Interaction do
  let(:twitter_interaction_name) { "Twitter" }
  let(:reddit_interaction_name) { "Reddit" }

  describe "validations" do
    describe "on type" do
      context "when type isn't present" do
        it "should be invalid" do
          expect(Interaction.new).to have_at_least(1).error_on(:type)
        end
      end

      context "when using subclass" do
        let(:user) { User.new }
        it "should be valid" do
          expect(user).to receive(:has_reddit_access?).and_return(true)
          expect(RedditInteraction.new(user: user)).to have(0).error_on(:type)
        end
      end
    end
  end

  describe ".new_by_name" do
    subject { Interaction.new_by_name(name) }

    context "when creating twitter interaction" do
      let(:name) { "TwitterInteraction" }
      it { should be_instance_of TwitterInteraction }
    end

    context "when creating reddit interaction" do
      let(:name) { "RedditInteraction" }
      it { should be_instance_of RedditInteraction }
    end

    context "when creating invalid interaction" do
      let(:name) { "NotSupportedInteraction" }
      it "raise error" do
        expect { subject }.to raise_error
      end
    end
  end

  describe "#act" do
    it "raises as it is an abstract method" do
      expect { Interaction.new.act }.to raise_error
    end
  end

  describe ".humanized_name" do
    subject { type.humanized_name }

    context "when twitter interaction is passed" do
      let(:type) { TwitterInteraction }
      it { should match twitter_interaction_name }
    end

    context "when reddit interaction is passed" do
      let(:type) { RedditInteraction }
      it { should match reddit_interaction_name }
    end
  end
end
