# frozen_string_literal: true

require "spec_helper"

require "chain_of_responsibility"

describe ChainOfResponsibility do
  class FakePassingHandler < described_class::Handler
    def resolve
      :ok
    end

    def applicable?
      true
    end
  end

  class FakeFailingHandler < described_class::Handler
    def resolve
      :error
    end

    def applicable?
      false
    end
  end

  class FakeExample
    include ChainOfResponsibility

    def_handler FakeFailingHandler
    def_handler FakePassingHandler
    def_handler FakeFailingHandler

    def call
      chain.call
    end
  end

  it "correctly builds handlers chain" do
    expect(FakeExample.new.call).to eq :ok
  end
end
