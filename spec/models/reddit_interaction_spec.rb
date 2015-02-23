require 'spec_helper'

describe RedditInteraction do
  describe ".atomic?" do
    subject { RedditInteraction.atomic? }
    it { should eq true }
  end
end
