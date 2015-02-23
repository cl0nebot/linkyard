require 'spec_helper'

describe CompositeInteraction do
  describe "validations" do
    describe "on interaction ids" do
      let(:user) { instance_double(User) }
      let(:interaction) { CompositeInteraction.new(user: user) }
      subject { interaction }

      context "when empty" do
        it { should have_at_least(1).error_on(:interaction_ids) }
      end

      context "when not user's interactions" do
        before { allow(user).to receive_message_chain("interactions.exists?").and_return(false) }
        it { should have_at_least(1).error_on(:interaction_ids) }
      end

      context "when user's interactions" do
        before { allow(user).to receive_message_chain("interactions.exists?").and_return(true) }
        it { should have(:no).error_on(:interaction_ids) }
      end
    end
  end

  describe ".atomic?" do
    subject { CompositeInteraction.atomic? }
    it { should eq false}
  end
end
