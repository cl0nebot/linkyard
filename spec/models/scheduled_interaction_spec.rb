require 'rails_helper'

describe ScheduledInteraction do
  describe "validations" do
    
  end

  describe ".atomic?" do
    subject { ScheduledInteraction.atomic? }
    it { should eq false}
  end
end
