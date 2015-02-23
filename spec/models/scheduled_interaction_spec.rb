require 'rails_helper'

describe ScheduledInteraction do
  describe "validations" do
    describe "on scheduled times" do
      let(:interaction) { ScheduledInteraction.new }
      subject { interaction }

      context "when empty"  do
        it { should have_at_least(1).error_on(:scheduled_times) }
      end

      context "when invalid times" do
        before { interaction.scheduled_times = [ "24:00", "111:00" ] }
        it { should have_at_least(1).error_on(:scheduled_times) }
      end

      context "when valid times" do
        before { interaction.scheduled_times = ["00:00", "16:30"] }
        it { should have(:no).error_on(:scheduled_times) }
      end
    end
  end

  describe ".atomic?" do
    subject { ScheduledInteraction.atomic? }
    it { should eq false}
  end
end
