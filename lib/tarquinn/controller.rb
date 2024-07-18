# frozen_string_literal: true

module Tarquinn
  # @api private
  #
  # Controller interface
  class Controller
    def initialize(controller)
      @controller = controller
    end

    # Returns request parameters
    #
    # @return [ActionController::Parameters]
    def params
      @params ||= controller.send(:params)
    end

    # Calls a method from the controller
    #
    # @param method [Symbol] method name to be called
    # @param args [Array<Symbol>] Method arguments
    # @param opts [Hash<Symbol,Object>] Method arguments
    #
    # @return [Object]
    def call(method, *args, **opts)
      controller.send(method, *args, **opts)
    end

    def run(&block)
      controller.send(:instance_eval, &block)
    end

    def method?(method)
      controller.respond_to?(method, true)
    end

    private

    attr_reader :controller
  end
end
