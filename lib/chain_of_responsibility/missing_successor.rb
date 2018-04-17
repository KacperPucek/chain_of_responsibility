# frozen_string_literal: true

require "chain_of_responsibility/errors/no_appropriate_handler_found_error"

module ChainOfResponsibility
  class MissingSuccessor
    def call(*)
      raise NoAppropriateHandlerFoundError
    end
  end
end
