# frozen_string_literal: true

require "chain_of_responsibility/handler"

module ChainOfResponsibility
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def handlers
      @handler ||= []
    end

    def def_handler(handler)
      handlers << handler
    end
  end

  def chain
    build_chain(self.class.handlers)
  end

  private

  def build_chain(handlers)
    handler, *remaining = handlers

    if remaining.empty?
      handler.new
    else
      handler.new(build_chain(remaining))
    end
  end
end
