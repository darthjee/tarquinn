# frozen_string_literal: true

module Tarquinn
  class Condition
    # @api private
    #
    # Checks condition based on a given block
    class ProcRunner < Tarquinn::Condition
      # @param block [Proc] block to be evaluated when the condition is checked
      #
      # @yield block evaluated in the context of the controller
      # @yieldreturn [Boolean] whether the condition is met
      #
      # @return [Tarquinn::Condition::ProcRunner]
      def initialize(&block)
        @block = block
      end

      # Checks if the block evaluates to a truthy value in the controller context
      #
      # @param controller [Tarquinn::Controller] the controller with the request params
      #
      # @return [TrueClass] when the block returns truthy
      # @return [FalseClass] when the block returns falsy
      def check?(controller)
        controller.run(&block)
      end

      private

      # @api private
      # @private
      #
      # Block to be evaluated when checking the condition
      #
      # @return [Proc]
      attr_reader :block
    end
  end
end
