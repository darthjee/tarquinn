# frozen_string_literal: true

module Tarquinn
  # @api private
  #
  # Engine processing a request defining the flow
  class Engine
    attr_reader :configs, :controller

    def initialize(configs, controller)
      @configs = configs
      @controller = controller
    end

    def perform_redirect
      return unless perform_redirect?

      handler_redirector.redirect
    end

    private

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
