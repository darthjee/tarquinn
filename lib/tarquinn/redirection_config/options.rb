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
      # hosts and the domain will be used for validation
      #
      # @return [String, nil] the domain for cross-domain redirection
      # @see RedirectionHandler#redirect
      # @see #redirection_options

      # @method initialize(domain: nil)
      # @api private
      # Initializes a new Options object
      # @param domain [String, nil] the domain for cross-domain redirection
      # @return [Tarquinn::RedirectionConfig::Options]

      # Options to be passed for the controller on redirect_to
      # @return [Hash] the options for the redirection
      def redirection_options
        {
          allow_other_host:
        }.compact
      end

      # Checks if the domain option is set
      # @return [TrueClass] when the domain option is set
      # @return [FalseClass] when the domain option is not set
      def domain?
        domain.present?
      end

      private

      # Returns the value of the allow_other_host option
      # @return [TrueClass, nil] the value of the allow_other_host option
      def allow_other_host
        domain? || nil
      end
    end
  end
end
