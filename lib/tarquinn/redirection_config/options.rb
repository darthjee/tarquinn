# frozen_string_literal: true

module Tarquinn
  class RedirectionConfig
    # @api private
    # Options for the RedirectionConfig class.
    #
    # These will be implemented in the future
    #
    # @see Tarquinn::RedirectionConfig
    class Options < Sinclair::Options
      with_options :domain

      # @method domain
      # @api private
      # The domain when a redirection is cross-domain
      #
      # if not set, the redirection be for the same host
      # and not allowed for external hosts.
      #
      # if set, the redirection will be allowed for external
      # hosts and the domain will be used for validation.
      # A Symbol value is resolved at runtime via the controller method.
      #
      # @return [String, Symbol, nil] the domain for cross-domain redirection
      # @see RedirectionHandler#redirect

      # @method initialize(domain: nil)
      # @api private
      # Initializes a new Options object
      # @param domain [String, Symbol, nil] the domain for cross-domain redirection.
      #   A String is used as-is; a Symbol is resolved by calling the matching
      #   method on the controller at runtime (via {Tarquinn::RedirectionHandler}).
      # @return [Tarquinn::RedirectionConfig::Options]
    end
  end
end
