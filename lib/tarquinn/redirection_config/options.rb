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
        { allow_other_host: nil }.compact
      end
    end
  end
end
