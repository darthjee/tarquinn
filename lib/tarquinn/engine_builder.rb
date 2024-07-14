# frozen_string_literal: true

module Tarquinn
  # @api private
  #
  # Redirections rules builder
  #
  # @see Tarquinn::Config
  # @see Tarquinn::Engine
  # @see Tarquinn::Controller
  class EngineBuilder
    # Creates a redirection rule
    #
    # The rule name defines which method will be called when checking the path of redirection
    #
    # @param redirection [Symbol] Rule name and method with redirection path
    # @param methods [Array<Symbol>] Methods that tell that a redirection should be applied
    # @param block [Proc] block that tells if a the redirection should be applied
    #
    # @return [NilClass] When no block is given
    # @return [Array] Current registered conditions
    def add_redirection_config(redirection, *methods, block)
      config_for(redirection).add_redirection_rules(*methods, &block)
    end

    # Attaches a condition to skip a redirection based on route (controller action)
    #
    # When any of the skip rules is met the redirection is skipped
    #
    # @param redirection [Symbol] Rule name to attach the skip condition
    # @param actions [Array<Symbol>] Route actions to be skipped
    #
    # @return [NilClass] When no block is given
    # @return [Array] Current registered conditions
    def add_skip_action(redirection, *actions)
      config_for(redirection).add_skip_action(*actions)
    end

    # Attaches conditions to skip a redirection
    #
    # Methods and blocks are ran and if any returns true, the redirec is skipped
    #
    # @param redirection [Symbol] Rule name to attach the skip condition
    # @param methods [Array<Symbol>] Methods that tell that a redirection should be skipped
    # @param block [Proc] block that tells if a the redirection should be skipped
    #
    # @return [NilClass] When no block is given
    # @return [Array] Current registered conditions
    def add_skip_config(redirection, *methods, block)
      config_for(redirection).add_skip_rules(*methods, &block)
    end

    # Builds a new engine to process a request
    #
    # @param controller [ActionController::Base] Controller handling the request
    #
    # @return [Tarquinn::Engine]
    def build(controller)
      controller = Tarquinn::Controller.new(controller)
      Tarquinn::Engine.new(configs, controller)
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
    # @return [Tarquinn::Config]
    def config_for(redirection)
      configs[redirection.to_sym] ||= Tarquinn::Config.new(redirection)
    end

    # @api private
    # @private
    #
    # Returns all configurations for all redirections for the controller
    #
    # @return [Hash<Symbol,Tarquinn::Config>]
    def configs
      @configs ||= {}
    end
  end
end
