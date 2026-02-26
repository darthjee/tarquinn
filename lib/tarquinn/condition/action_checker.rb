# frozen_string_literal: true

module Tarquinn
  class Condition
    # @api private
    #
    # Checks condition based on route action
    class ActionChecker < Tarquinn::Condition
      # @param routes [Array<Symbol>] controller actions that trigger the condition
      #
      # @return [Tarquinn::Condition::ActionChecker]
      def initialize(routes)
        @routes = [routes].flatten.map(&:to_s)
      end

      # Checks if the current request action matches any of the configured routes
      #
      # @param controller [Tarquinn::Controller] the controller with the request params
      #
      # @return [TrueClass] when the current action is in the routes list
      # @return [FalseClass] when the current action is not in the routes list
      def check?(controller)
        routes.include? controller.params[:action]
      end

      # Checks equality with another object
      #
      # @param other [Object] the object to compare with
      #
      # @return [TrueClass] when the other object is of the same class and has the same routes
      # @return [FalseClass] otherwise
      def ==(other)
        return false unless other.class == self.class

        other.routes == routes
      end

      protected

      # @api private
      # @private
      #
      # Controller actions that trigger the condition
      #
      # @return [Array<String>]
      attr_reader :routes
    end
  end
end
