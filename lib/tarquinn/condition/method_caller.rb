# frozen_string_literal: true

module Tarquinn
  class Condition
    # @api private
    #
    # Checks condition based on result of method call from controller
    class MethodCaller < Tarquinn::Condition
      # @param methods [Array<Symbol>] list of methods to be called for condition
      #
      # @return [Tarquinn::Condition::MethodCaller]
      def initialize(methods)
        @methods = [methods].flatten
      end

      # Checks if any of the configured methods returns a truthy value
      #
      # @param controller [Tarquinn::Controller] the controller with the request params
      #
      # @return [TrueClass] when any of the methods returns truthy
      # @return [FalseClass] when all methods return falsy
      def check?(controller)
        methods.any? do |method|
          controller.call(method)
        end
      end

      # Checks equality with another object
      #
      # @param other [Object] the object to compare with
      #
      # @return [TrueClass] when the other object is of the same class and has the same methods
      # @return [FalseClass] otherwise
      def ==(other)
        return false unless other.class == self.class

        other.methods == methods
      end

      protected

      # @api private
      #
      # Methods to be called when checking the condition
      #
      # @return [Array<Symbol>]
      attr_reader :methods
    end
  end
end
