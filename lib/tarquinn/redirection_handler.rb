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
      controller.call(:redirect_to, redirect_full_path, **redirection_options)
    end

    # Options to be passed for the controller on redirect_to
    #
    # @return [Hash] the options for the redirection
    def redirection_options
      { allow_other_host: }.compact
    end

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

    # @method redirection_blocks
    # @api private
    # @private
    # All blocks that indicate a redirection
    # @return [Array<Tarquinn::Condition>] all blocks that indicate a redirection

    # @method skip_blocks
    # @api private
    # @private
    # All blocks that indicate a redirection should be skipped
    # @return (see Tarquinn::RedirectionConfig#skip_blocks)
    # @see Tarquinn::RedirectionConfig#skip_blocks

    # @api private
    # @private
    #
    # Resolves the domain for cross-domain redirection
    #
    # When the configured domain is a Symbol and the controller responds to
    # that method, the method is called and its return value is used.
    # Otherwise, the configured value is returned as-is (a String is used
    # directly; a Symbol that the controller does not respond to is converted
    # to a String via `#to_s`).
    #
    # @return [String, nil] the resolved domain
    def domain
      raw = config.domain
      return controller.call(raw) if raw.is_a?(Symbol) && controller.method?(raw)

      raw
    end

    # @api private
    # @private
    #
    # Checks if the resolved domain is set
    #
    # @return [TrueClass] when the domain is set
    # @return [FalseClass] when the domain is not set
    def domain?
      domain.present?
    end

    # @api private
    # @private
    #
    # Returns the value of the allow_other_host option
    #
    # @return [TrueClass, nil] the value of the allow_other_host option
    def allow_other_host
      domain? || nil
    end

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
    # Returns the full redirection path, including the domain if set
    # @return [String] the full redirection path
    def redirect_full_path
      domain? ? "#{domain}#{redirect_path}" : redirect_path
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
