# frozen_string_literal: true

module Tarquinn
  class Condition
    # @api private
    #
    # Checks condition based on route action
    class ActionChecker < Tarquinn::Condition
      def initialize(routes)
        @routes = [routes].flatten.map(&:to_s)
      end

      def check?(controller)
        routes.include? controller.params[:action]
      end

      def ==(other)
        return false unless other.class == self.class

        other.routes == routes
      end

      protected

      attr_reader :routes
    end
  end
end
