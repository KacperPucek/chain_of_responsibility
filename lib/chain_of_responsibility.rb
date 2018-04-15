require "chain_of_responsibility/version"
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
    handler, *handlers = handlers

    if handlers.empty?
      handler.new
    else
      handler.new(make_chain(handlers))
    end
  end
end
