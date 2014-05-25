require 'spec_helper'

describe Link do
  
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
