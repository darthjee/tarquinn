# frozen_string_literal: true

module Tarquinn
  class Condition
    # @api private
    #
    # Checks condition based on result of method call from controller
    class MethodCaller < Tarquinn::Condition
      def initialize(methods)
        @methods = [methods].flatten
      end

      def check?(controller)
        methods.any? do |method|
          controller.call(method)
        end
      end

      def ==(other)
        return false unless other.class == self.class

        other.methods == methods
      end

      protected

      attr_reader :methods
    end
  end
end
