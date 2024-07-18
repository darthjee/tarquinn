# frozen_string_literal: true

module Tarquinn
  # @api private
  #
  # Redirect config handler
  #
  # Checks if one redirection rule should or should not be applied
  class RedirectionHandler
    # @param config [Tarquinn::RedirectionConfig] redirection configuration
    # @param controller [Tarquinn::Controller] controller interface
    def initialize(config, controller)
      @config = config
      @controller = controller
    end

    # Checks if redirection should be performd
    #
    # @return [TrueClass] when redirection should be performed
    # @return [FalseClass] when redirection should not be performed
    def perform_redirect?
      return perform_redirect if instance_variable_defined?(:@perform_redirect)

      @perform_redirect = redirect?
    end

    # Performs redirction to a new route
    #
    # @return [String] redirection body
    def redirect
      controller.call(:redirect_to, redirect_path)
    end

    private

    attr_reader :config, :controller, :perform_redirect

    delegate :redirection_blocks, :skip_blocks, to: :config

    # Returns method in the controller that returns the redirection path
    #
    # @return [Symbol] method name
    def redirect_method
      config.redirect
    end

    # Returns the redirection path
    #
    # when redirection path method does not exist, then then
    # the redirection name is used
    #
    # @return [String]
    def redirect_path
      return redirect_method unless controller.method?(redirect_method)

      controller.call redirect_method
    end

    # Checks if a redirection should be performd
    #
    # @return [TrueClass]
    # @return [FalseClass]
    def redirect?
      return false if blocks_skip_redirect?

      blocks_require_redirect?
    end

    # Checks if redirection should be skipped
    #
    # @return [TrueClass]
    # @return [FalseClass]
    def blocks_skip_redirect?
      check_blocks(skip_blocks)
    end

    # Checks if redirection should be applied (not concerning the skip blocks)
    #
    # @return [TrueClass]
    # @return [FalseClass]
    def blocks_require_redirect?
      return true if redirection_blocks.empty?

      check_blocks(redirection_blocks)
    end

    # Check if any condition  returns positive
    #
    # @return [TrueClass]
    # @return [FalseClass]
    def check_blocks(blocks)
      blocks.any? do |block|
        block.check?(controller)
      end
    end
  end
end
