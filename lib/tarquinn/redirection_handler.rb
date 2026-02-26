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
    #
    # @return [Tarquinn::RedirectionHandler]
    def initialize(config, controller)
      @config = config
      @controller = controller
    end

    # Checks if redirection should be performed
    #
    # @return [TrueClass] when redirection should be performed
    # @return [FalseClass] when redirection should not be performed
    def perform_redirect?
      return perform_redirect if instance_variable_defined?(:@perform_redirect)

      @perform_redirect = redirect?
    end

    # Performs redirection to a new route
    #
    # @return [String] redirection body
    def redirect
      controller.call(:redirect_to, redirect_path, **redirection_options)
    end

    delegate :redirection_options, to: :config

    private

    # @api private
    # @private
    #
    # Redirection configuration for this handler
    #
    # @return [Tarquinn::RedirectionConfig]
    attr_reader :config

    # @api private
    # @private
    #
    # Controller interface for the current request
    #
    # @return [Tarquinn::Controller]
    attr_reader :controller

    # @api private
    # @private
    #
    # Memoized result of whether redirection should be performed
    #
    # @return [Boolean]
    attr_reader :perform_redirect

    delegate :redirection_blocks, :skip_blocks, to: :config

    # @api private
    # @private
    #
    # Returns method in the controller that returns the redirection path
    #
    # @return [Symbol] method name
    def redirect_method
      config.redirection
    end

    # @api private
    # @private
    #
    # Returns the redirection path
    #
    # when redirection path method does not exist, then
    # the redirection name is used
    #
    # @return [String]
    def redirect_path
      return redirect_method unless controller.method?(redirect_method)

      controller.call redirect_method
    end

    # @api private
    # @private
    #
    # Checks if a redirection should be performed
    #
    # @return [TrueClass]
    # @return [FalseClass]
    def redirect?
      return false if blocks_skip_redirect?

      blocks_require_redirect?
    end

    # @api private
    # @private
    #
    # Checks if redirection should be skipped
    #
    # @return [TrueClass]
    # @return [FalseClass]
    def blocks_skip_redirect?
      check_blocks(skip_blocks)
    end

    # @api private
    # @private
    #
    # Checks if redirection should be applied (not concerning the skip blocks)
    #
    # @return [TrueClass]
    # @return [FalseClass]
    def blocks_require_redirect?
      return true if redirection_blocks.empty?

      check_blocks(redirection_blocks)
    end

    # @api private
    # @private
    #
    # Checks if any condition returns positive
    #
    # @param blocks [Array<Tarquinn::Condition>] conditions to check
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
