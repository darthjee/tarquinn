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
    # @param block [Proc] block to be given to the method
    #
    # @return [Object]
    def call(method, *args, **opts, &block)
      controller.send(method, *args, **opts, &block)
    end

    # Run a block in teh context of the controller
    #
    # @param block [Proc] block to be ran
    #
    # @return [Object] the return of the block
    def run(&block)
      controller.send(:instance_eval, &block)
    end

    # Checks if the controller responds to a method
    #
    # @param method [Symbol] method name
    #
    # @return [TrueClass] the controller responds to this method
    # @return [FalseClass] the controller does not responds to this method
    def method?(method)
      controller.respond_to?(method, true)
    end

    private

    attr_reader :controller

    # @method controller
    # @api private
    # @private
    #
    # Returns the controller handling the request
    #
    # @return [ActionController::Base]
  end
end
