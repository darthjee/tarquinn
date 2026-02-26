# frozen_string_literal: true

module Tarquinn
  # @api public
  #
  # Exceptions raised by {Tarquinn}
  module Exception
    # @api public
    #
    # Raised when trying to create a redirection with a name already defined
    class RedirectionAlreadyDefined < StandardError
      # @api private
      #
      # @param redirection [Symbol] Redirection name that is already defined
      def initialize(redirection)
        super("Redirection #{redirection} already defined")
      end
    end
  end
end
