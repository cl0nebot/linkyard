require 'spec_helper'

describe Link do

  describe "validations" do
    describe "on title" do
      context "when title isn't there" do
        it "should be invalid" do
          
        end
      end

      context "when title is there" do
        it "should be valid" do
          
        end
      end
    end

    describe "on url" do
      context "when url is not there" do
        it "should be invalid" do
          
        end
      end

      context "when url is "
    end
  end


  describe "#save_and_publish" do
    # how to effectively test this type of code?
    #
    # my approach
    # 1) create dummy link + link_interactions here in the test
    # 2) stub InteractionWorker.perform_async
    # 3) check whether it was called with right parameters
    #
    # Test case without any interactions
  end
  
end
