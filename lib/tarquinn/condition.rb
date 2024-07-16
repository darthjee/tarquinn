# frozen_string_literal: true

module Tarquinn
  # @api private
  # @abstract
  #
  # Redirection condition
  class Condition
    autoload :ActionChecker, 'tarquinn/condition/action_checker'
    autoload :MethodCaller,  'tarquinn/condition/method_caller'
    autoload :ProcRunner,    'tarquinn/condition/proc_runner'

    class << self
      # Creates a method caller condition
      #
      # @param methods [Array<Symbol>] list of methods to be called for condition
      #
      # @return [Tarquinn::Condition::MethodCaller]
      def method_caller(methods)
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

      def proc_runner(&block)
        return unless block
        Tarquinn::Condition::ProcRunner.new(&block)
      end
    end

    # Checks if a condition is matched
    #
    # @param _controller [Tarquinn::Controller] the controller with the request params
    #
    # @return [TrueClass] When it is a match
    # @return [FalseClass] When it is not a match
    def check?(_controller)
      raise NotImplementedError, 'Needs to be implemented in child class'
    end
  end
end
