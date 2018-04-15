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
    let(:passing_handler_klass) do
      Class.new(described_class) do
        def resolve
          :ok
        end

        def applicable?
          true
        end
      end
    end

    let(:failing_handler_klass) do
      Class.new(described_class) do
        def resolve
          :error
        end

        def applicable?
          false
        end
      end
    end

    context "when handler is applicable" do
      it "calls resolve" do
        handler = passing_handler_klass.new

        expect(handler.call).to eq :ok
      end
    end

    context "when handler is not applicable" do
      context "when another handler is defined" do
        it "calls him" do
          handler = failing_handler_klass.new(passing_handler_klass.new)

          expect(handler.call).to eq :ok
        end
      end

      context "when there are not other handlers" do
        it "raises NoAppropriateHandlerFoundError error" do
          handler = failing_handler_klass.new

          expect { handler.call }
            .to raise_error(ChainOfResponsibility::NoAppropriateHandlerFoundError)
        end
      end
    end
  end
end
