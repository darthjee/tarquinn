# frozen_string_literal: true

module Tarquinn
  module Condition
    class ProcRunner
      attr_reader :block

      def initialize(&block)
        @block = block
      end

      def check?(controller)
        block.yield(controller)
      end
    end
  end
end
