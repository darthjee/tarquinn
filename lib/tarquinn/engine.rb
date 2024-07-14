# frozen_string_literal: true

module Tarquinn
  # @api private
  #
  # Engine processing a request defining the flow
  class Engine
    # @method configs
    # @api private
    #
    # All redirect configs
    #
    # @return [Hash<Symbol,Tarquinn::Config>]

    # @method controller
    #
    # Controller interface
    #
    # @return [Tarquinn::Controller]

    # @param configs [Hash<Symbol,Tarquinn::Config>] All redirect configs
    # @param controller [Tarquinn::Controller] Controller interface
    def initialize(configs, controller)
      @configs = configs
      @controller = controller
    end

    # Performs redirection if enabled / needed
    #
    # The rules / configuratons are processed in order
    # and if any is positive, it will be processed
    #
    # @return [NilClass] Nothing when no redirection is performed
    # @return [String] The result of the redirection
    def perform_redirect
      return unless perform_redirect?

      handler_redirector.redirect
    end

    private

    attr_reader :configs, :controller

    def perform_redirect?
      handler_redirector.present?
    end

    def handler_redirector
      @handler_redirector ||= handlers.find(&:perform_redirect?)
    end

    def handlers
      @handlers ||= build_handlers
    end

    def build_handlers
      configs.map { |_, c| Tarquinn::Handler.new(c, controller) }
    end
  end
end
