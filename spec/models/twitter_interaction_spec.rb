require 'spec_helper'

describe TwitterInteraction do
  let(:user) { User.new }
  let(:interaction) { TwitterInteraction.new.tap { |i| i.user = user} }

  describe "validations" do
    describe "on connection to twitter" do
      context "when user has a connection to Twitter" do
        before { user.stub(:has_twitter_access?) { true } }
        it "should be valid" do
          expect(interaction).to have(0).error_on(:base)
        end
      end

      context "when user doesn't have a connection to Twitter" do
        before { user.stub(:has_twitter_access?) { false } }
        it "should be invalid" do
          expect(interaction).to have(1).error_on(:base)
        end
      end
    end
  end

  describe "#act" do
    let(:tag) { Tag.new(name: "digest") }
    let(:link) { Link.new(:title => "Awesome", :url => "http://awesome.io", user: user).tap { |l| l.tags << tag } }
    let(:twitter_authorization) { Authorization.new(:token => "t", :secret => "s") }
    let(:link_interaction) { double() }
    before { user.stub(:twitter_authorization) { twitter_authorization }}

    it "should tweet" do
      expect_any_instance_of(Twitter::REST::Client).to receive(:update).with("#{link.title} #{link.url} #digest")
      allow(link_interaction).to receive(:link).and_return(link)
      expect(link_interaction).to receive(:update_and_notify!).with(:success, "submitted")
      interaction.act(link_interaction)
    end
  end

end
