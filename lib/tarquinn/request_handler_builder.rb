# frozen_string_literal: true

module Tarquinn
  # @api private
  #
  # Redirections rules builder
  #
  # @see Tarquinn::RedirectionConfig
  # @see Tarquinn::RequestHandler
  # @see Tarquinn::Controller
  class RequestHandlerBuilder
    # Creates a redirection rule
    #
    # The rule name defines which method will be called when checking the path of redirection
    #
    # @param redirection [Symbol] Rule name and method with redirection path
    # @param options [Hash] additional options for the redirection rule
    #   (using {RedirectionConfig::Options})
    # @param (see Tarquinn::RedirectionConfig#add_redirection_rules)
    #
    # @see Tarquinn::RedirectionConfig::Options
    # @return [Tarquinn::RedirectionConfig] the newly built configuration
    def add_redirection_config(redirection, *methods, **options, &block)
      RedirectionConfigBuilder.build(configs:, redirection:, options:) do |config|
        config.add_redirection_rules(*methods, &block)
      end
    end

    # Attaches a condition to skip a redirection based on route (controller action)
    #
    # When any of the skip rules is met the redirection is skipped
    #
    # @param redirection [Symbol] Rule name to attach the skip condition
    # @param (see Tarquinn::RedirectionConfig#add_skip_action)
    #
    # @return (see Tarquinn::RedirectionConfig#add_skip_action)
    def add_skip_action(redirection, *actions)
      config_for(redirection).add_skip_action(*actions)
    end

    # Attaches conditions to skip a redirection
    #
    # Methods and blocks are ran and if any returns true, the redirec is skipped
    #
    # @param redirection [Symbol] Rule name to attach the skip condition
    # @param (see Tarquinn::RedirectionConfig#add_skip_rules)
    #
    # @return (see Tarquinn::RedirectionConfig#add_skip_rules)
    def add_skip_config(redirection, *methods, &block)
      config_for(redirection).add_skip_rules(*methods, &block)
    end

    # Builds a new engine to process a request
    #
    # @param controller [ActionController::Base] Controller handling the request
    #
    # @return [Tarquinn::RequestHandler]
    def build(controller)
      controller = Tarquinn::Controller.new(controller)
      Tarquinn::RequestHandler.new(configs, controller)
    end

    private

    # @api private
    # @private
    #
    # Returns the configuration for one redirection
    #
    # When none is configured, a new one is created
    #
    # @param redirection [Symbol] redirection_name
    #
    # @return [Tarquinn::RedirectionConfig]
    def config_for(redirection)
      configs[redirection.to_sym] ||= Tarquinn::RedirectionConfig.new(redirection:)
    end

    # @api private
    # @private
    #
    # Returns all configurations for all redirections for the controller
    #
    # @return [Hash<Symbol,Tarquinn::RedirectionConfig>]
    def configs
      @configs ||= {}
    end
  end
end
