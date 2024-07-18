# frozen_string_literal: true

module Tarquinn
  # @api private
  #
  # Redirect config handler
  #
  # Checks if one redirection rule should or should not be applied
  class RedirectionHandler
    def initialize(config, controller)
      @config = config
      @controller = controller
    end

    def perform_redirect?
      return perform_redirect if instance_variable_defined?(:@perform_redirect)

      @perform_redirect = redirect?
    end

    def redirect
      controller.call(:redirect_to, redirect_path)
    end

    private

    attr_reader :config, :controller, :perform_redirect

    delegate :redirection_blocks, :skip_blocks, to: :config

    def redirect_method
      config.redirect
    end

    def redirect_path
      return redirect_method unless controller.method?(redirect_method)

      controller.call redirect_method
    end

    def redirect?
      return false if blocks_skip_redirect?

      blocks_require_redirect?
    end

    def blocks_skip_redirect?
      check_blocks(skip_blocks)
    end

    def blocks_require_redirect?
      return true if redirection_blocks.empty?

      check_blocks(redirection_blocks)
    end

    def check_blocks(blocks)
      blocks.any? do |block|
        block.check?(controller)
      end
    end
  end
end
