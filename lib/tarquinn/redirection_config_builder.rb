# frozen_string_literal: true

module Tarquinn
  # @!parse class RedirectionConfigBuilder < Sinclair::Model; end
  # @api private
  # Redirections rules builder
  #
  # Builds redirection rule and attaches it to the config collection.
  #
  # Before building the redirection rule, it checks if a rule with the same name already exists
  # and raises an error if it does.
  # @see Tarquinn::RedirectionConfig
  # @see Tarquinn::RequestHandler
  # @see Tarquinn::Controller
  class RedirectionConfigBuilder < Sinclair::Model.for(:configs, :redirection, :options, writter: false)
    # @method configs
    # @api private
    #
    # Returns all configurations for all redirections for the controller
    #
    # @return [Array<Tarquinn::RedirectionConfig>] the collection of redirection rules

    # @method redirection
    # @api private
    #
    # Returns the name of the redirection rule being built
    #
    # @return [Symbol] the name of the redirection rule being built

    # @method initialize(configs:, redirection:, options: {})
    # @api private
    # @param configs [Array<Tarquinn::RedirectionConfig>] the collection of redirection rules
    # @param redirection [Symbol] the name of the redirection rule being built
    # @param options [Hash] additional options for the redirection rule

    # Builds a new redirection rule and adds it to the collection of rules
    #
    # @overload self.build(configs:, redirection:, options:, &block)
    # @param (see Tarquinn::RedirectionConfigBuilder#initialize)
    # @param block [Proc] block that will be used to add conditions to the redirection rule
    #
    # @yield [Tarquinn::RedirectionConfig] the newly built configuration
    #
    # @see RequestHandlerBuilder#add_redirection_config
    # @see RedirectionConfig::Options
    # @return [Tarquinn::RedirectionConfig] the newly built configuration
    def self.build(**attributes, &block)
      new(**attributes).build(&block)
    end

    # Builds a new redirection rule and adds it to the collection of rules
    #
    # @param block [Proc] block that will be used to add conditions to the redirection rule
    # @yield [Tarquinn::RedirectionConfig] the newly built configuration
    # @return [Tarquinn::RedirectionConfig] the newly built configuration
    def build(&block)
      check_redirection_exists!

      config.tap(&block)
    end

    private

    # Builds a new redirection rule and adds it to the collection of rules
    #
    # @return [Tarquinn::RedirectionConfig] the newly built configuration
    def config
      configs[redirection.to_sym] = Tarquinn::RedirectionConfig.new(redirection:, **options)
    end

    # Checks if a redirection rule with the same name already exists
    #
    # @raise [Tarquinn::Exception::RedirectionAlreadyDefined] when a redirection rule with the same
    #   name already exists
    #
    # @return [NilClass] when no redirection rule with the same name exists
    def check_redirection_exists!
      raise Exception::RedirectionAlreadyDefined, redirection if config_exists?
    end

    # Checks if a redirection rule with the same name already exists
    # @return [TrueClass] when a redirection rule with the same name already exists
    # @return [FalseClass] when a redirection rule with the same name does not exist
    def config_exists?
      configs[redirection.to_sym]
    end
  end
end
