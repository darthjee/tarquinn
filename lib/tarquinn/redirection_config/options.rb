# frozen_string_literal: true

module Tarquinn
  class RedirectionConfig
    # Options for the RedirectionConfig class.
    #
    # These will be implemented in the future
    #
    # @see Tarquinn::RedirectionConfig
    class Options < Sinclair::Options
      with_options :domain

      def redirection_options
        {
          allow_other_host: allow_other_host?
        }.compact
      end

      def domain?
        domain.present?
      end

      private

      def allow_other_host?
        domain? ? true : nil
      end
    end
  end
end
