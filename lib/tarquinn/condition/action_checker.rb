# frozen_string_literal: true

module Tarquinn
  module Condition
    # @api private
    #
    # Checks condition based on route action
    class ActionChecker
      attr_accessor :routes

      def initialize(routes)
        @routes = [routes].flatten.map(&:to_s)
      end

      def check?(controller)
        routes.include? controller.params[:action]
      end
    end
  end
end
