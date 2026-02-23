# frozen_string_literal: true

module Tarquinn
  # @api private
  #
  # Controller interface
  class Controller
    # Initializes a new controller interface
    #
    # @param controller [ActionController::Base] the Rails controller handling the request
    #
    # @return [Tarquinn::Controller]
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

    # Runs a block in the context of the controller
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
    # @return [TrueClass] when the controller responds to this method
    # @return [FalseClass] when the controller does not respond to this method
    def method?(method)
      controller.respond_to?(method, true)
    end

    private

    # @api private
    # @private
    #
    # Returns the Rails controller handling the request
    #
    # @return [ActionController::Base]
    attr_reader :controller
  end
end
