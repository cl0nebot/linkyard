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

  describe "#ready?" do
    subject { ScheduledInteraction.new(scheduled_times: ["10:00", "16:30"]).ready?(time)}

    context "when there is less than 30 minutes from scheduled time" do
      let(:time) { DateTime.parse("10:05") }
      it { should eq true}
    end

    context "when there is more than 30 minutes from scheduled time" do
      let(:time) { DateTime.parse("23:17") }
      it { should eq false }
    end

    context "when the time is just before scheduled time" do
      let(:time) { DateTime.parse("15:55") }
      it { should eq false }
    end
  end

  describe "#act" do
    let(:link_interaction) { instance_double(LinkInteraction) }
    let(:interaction) { ScheduledInteraction.new }
    subject { interaction.act(link_interaction) }

    context "when there is an error" do
    end

    context "when all succeeded" do
    end
  end
end
