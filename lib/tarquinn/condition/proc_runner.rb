# frozen_string_literal: true

module Tarquinn
  class Condition
    # @api private
    #
    # Checks condition based on a given block
    class ProcRunner < Tarquinn::Condition
      def initialize(&block)
        @block = block
      end

      def check?(controller)
        block.yield(controller)
      end

      private

      attr_reader :block
    end
  end
end
