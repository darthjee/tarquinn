# frozen_string_literal: true

module Tarquinn
  module Condition
    class MethodCaller
      attr_accessor :methods

      def initialize(methods)
        @methods = [methods].flatten
      end

      def check?(controller)
        methods.any? do |method|
          controller.call(method)
        end
      end
    end
  end
end
