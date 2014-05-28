require 'spec_helper'

describe Link do

  describe "validations" do
    let(:link) { Link.new }

    describe "on title" do
      context "when title isn't there" do
        it "should be invalid" do
          expect(link).to have_at_least(1).error_on(:title)
        end
      end

      context "when title is there" do
        it "should be valid" do
          link.title = "Super awesome title"
          expect(link).to have(:no).error_on(:title)
        end
      end
    end

    describe "on url" do
      context "when url is not there" do
        it "should be invalid" do
          expect(link).to have_at_least(1).error_on(:url)
        end
      end

      context "when url doesn't start with http://" do
        it "should prepend http:// and be valid"  do
          link.url = "www.betterthangoogle.io"
          expect(link).to have(:no).error_on(:url)
          expect(link.url).to match("http://www.betterthangoogle.io")
        end
      end

      context "when url is valid" do
        it "should be valid" do
          link.url = "https://superawesomeurl.io"
          expect(link).to have(:no).error_on(:url)
        end
      end
    end
  end

  describe "#save_and_publish" do
    let!(:user) { User.create!(:email => "j@oh.ny", :password => "12345678", :password_confirmation => "12345678") }
    let(:link) { user.links.new }
    let(:first_interaction) { LinkInteraction.new(:interaction_id => 123) }
    let(:second_interaction) { LinkInteraction.new(:interaction_id => 124) }

    def initialize_and_save_link!
      link.title = "Super awesome"
      link.url = "http://awesome.io"
      link.link_interactions << first_interaction
      link.link_interactions << second_interaction
    end

    subject { link.save_and_publish }

    context "when link is valid and has interactions" do
      before do
        initialize_and_save_link!
      end

      it "should return true and perform interactions" do
        link.link_interactions.each do |li|
          expect(InteractionWorker).to receive(:perform_async) do |id|
            expect(id).not_to be_nil
            expect(id).to eq li.id
          end
        end
        expect(subject).to be_true
      end
    end

    context "when link is valid and hasn't interactions" do
      before do
        link.title = "Astonishing title"
        link.url = "http://astonish.io"
      end
      
      it "should return true and not do anything else" do
        expect(InteractionWorker).not_to receive(:perform_async)
        expect(subject).to be_true
      end
    end

    context "when link is invalid and has interactions" do
      before do
        initialize_and_save_link!
        link.title = nil
      end

      it "should return false and not perform any interaction" do
        expect(InteractionWorker).not_to receive(:perform_async)
        expect(subject).to be_false
      end
    end
  end
end
