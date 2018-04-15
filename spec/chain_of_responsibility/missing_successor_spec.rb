require "spec_helper"

require "chain_of_responsibility/missing_successor"

describe ChainOfResponsibility::MissingSuccessor do
  describe "#call" do
    it "raises NoAppropriateHandlerFoundError error" do
      missing_successor = described_class.new

      expect { missing_successor.call }
        .to raise_error(ChainOfResponsibility::NoAppropriateHandlerFoundError)
    end
  end
end
