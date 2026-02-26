# frozen_string_literal: true

module Tarquinn
  # @api private
  # @abstract
  #
  # Redirection condition
  # Conditions are used to check if a redirection should be performed or not.
  #
  # They can be based on controller actions, custom methods or blocks
  #
  # Each condition type is implemented in a different class, but they all inherit
  # from this one and implement the check? method
  class Condition
    autoload :ActionChecker, 'tarquinn/condition/action_checker'
    autoload :MethodCaller,  'tarquinn/condition/method_caller'
    autoload :ProcRunner,    'tarquinn/condition/proc_runner'

    class << self
      # Creates a method caller condition
      #
      # @param methods [Array<Symbol>] list of methods to be called for condition
      #
      # @return [Tarquinn::Condition::MethodCaller] when methods are given
      # @return [NilClass] when no methods are given
      def method_caller(methods)
        return if methods.empty?

        Tarquinn::Condition::MethodCaller.new(methods)
      end

      # Creates an action checker condition
      #
      # @param routes [Array<Symbol>] controller actions that will match the condition
      #
      # @return [Tarquinn::Condition::ActionChecker]
      def action_checker(routes)
        Tarquinn::Condition::ActionChecker.new(routes)
      end

      # Cretes a proc checker
      #
      # @param block [Proc] block to be ran when condition is checked
      #
      # @return [Tarquinn::Condition::ProcRunner] When a block is given
      # @return [NilClass] when no block is given
      def proc_runner(&block)
        return unless block

        Tarquinn::Condition::ProcRunner.new(&block)
      end
    end

    # Checks if a condition is matched
    #
    # @param _controller [Tarquinn::Controller] the controller with the request params
    #
    # @raise [NotImplementedError] when not implemented in child class
    #
    # @return [TrueClass] When it is a match
    # @return [FalseClass] When it is not a match
    def check?(_controller)
      raise NotImplementedError, 'Needs to be implemented in child class'
    end
  end
end
