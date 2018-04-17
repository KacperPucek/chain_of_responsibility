# frozen_string_literal: true

require "chain_of_responsibility/errors/method_not_implemented_error"
require "chain_of_responsibility/missing_successor"

module ChainOfResponsibility
  class Handler
    def initialize(successor = MissingSuccessor.new)
      @successor = successor
    end

    attr_reader :successor

    def call(*args)
      if applicable?(*args)
        resolve(*args)
      else
        successor.call(*args)
      end
    end

    def resolve(*)
      raise MethodNotImplementedError, "resolve"
    end

    def applicable?(*)
      raise MethodNotImplementedError, "applicable?"
    end
  end
end
