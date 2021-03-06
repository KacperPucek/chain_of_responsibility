# frozen_string_literal: true

require "spec_helper"

require "chain_of_responsibility/handler"

describe ChainOfResponsibility::Handler do
  describe "#resolve" do
    context "when method is not implemented" do
      it "raises MethodNotImplementedError error" do
        handler = described_class.new

        expect { handler.resolve }
          .to raise_error(ChainOfResponsibility::MethodNotImplementedError, "resolve")
      end
    end
  end

  describe "#applicable?" do
    context "when method is not implemented" do
      it "raises MethodNotImplementedError error" do
        handler = described_class.new

        expect { handler.applicable? }
          .to raise_error(ChainOfResponsibility::MethodNotImplementedError, "applicable?")
      end
    end
  end

  describe "#call" do
    class FakePassingHandler < described_class
      def resolve
        :ok
      end

      def applicable?
        true
      end
    end

    class FakeFailingHandler < described_class
      def resolve
        :error
      end

      def applicable?
        false
      end
    end

    context "when handler is applicable" do
      it "calls resolve" do
        handler = FakePassingHandler.new

        expect(handler.call).to eq :ok
      end
    end

    context "when handler is not applicable" do
      context "when another handler is defined" do
        it "calls him" do
          handler = FakeFailingHandler.new(FakePassingHandler.new)

          expect(handler.call).to eq :ok
        end
      end

      context "when there are not other handlers" do
        it "raises NoAppropriateHandlerFoundError error" do
          handler = FakeFailingHandler.new

          expect { handler.call }
            .to raise_error(ChainOfResponsibility::NoAppropriateHandlerFoundError)
        end
      end
    end
  end
end
