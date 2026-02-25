# frozen_string_literal: true

module Tarquinn
  module Exception
    class RedirectionAlreadyDefined < StandardError
      def initialize(redirection)
        super("Redirection #{redirection} already defined")
      end
    end
  end
end
