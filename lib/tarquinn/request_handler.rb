# frozen_string_literal: true

module Tarquinn
  # @api private
  #
  # RequestHandler processing a request defining the flow
  class RequestHandler
    # @param configs [Hash<Symbol,Tarquinn::RedirectionConfig>] All redirect configs
    # @param controller [Tarquinn::Controller] Controller interface
    #
    # @return [Tarquinn::RequestHandler]
    def initialize(configs, controller)
      @configs = configs
      @controller = controller
    end

    # Performs redirection if enabled / needed
    #
    # The rules / configurations are processed in order
    # and if any is positive, it will be processed
    #
    # @return [NilClass] Nothing when no redirection is performed
    # @return [String] The result of the redirection
    def perform_redirect
      return unless perform_redirect?

      handler_redirector.redirect
    end

    private

    # @api private
    # @private
    #
    # All redirect configs
    #
    # @return [Hash<Symbol,Tarquinn::RedirectionConfig>]
    attr_reader :configs

    # @api private
    # @private
    #
    # Controller interface
    #
    # @return [Tarquinn::Controller]
    attr_reader :controller

    # @api private
    # @private
    #
    # Checks if any redirection handler should be applied
    #
    # @return [TrueClass] when a redirect is required
    # @return [FalseClass] when no redirect is required
    def perform_redirect?
      handler_redirector.present?
    end

    # @api private
    # @private
    #
    # Returns the first handler that requires a redirect
    #
    # @return [Tarquinn::RedirectionHandler, nil] the matching handler, or nil if none
    def handler_redirector
      @handler_redirector ||= handlers.find(&:perform_redirect?)
    end

    # @api private
    # @private
    #
    # All redirection handlers built from the configs
    #
    # @return [Array<Tarquinn::RedirectionHandler>]
    def handlers
      @handlers ||= build_handlers
    end

    # @api private
    # @private
    #
    # Builds a handler for each redirection config
    #
    # @return [Array<Tarquinn::RedirectionHandler>]
    def build_handlers
      configs.values.map { |config| Tarquinn::RedirectionHandler.new(config, controller) }
    end
  end
end
