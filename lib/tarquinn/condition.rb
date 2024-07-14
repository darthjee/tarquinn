# frozen_string_literal: true

module Tarquinn
  # @api private
  #
  # Redirection condition
  class Condition
    autoload :ActionChecker, 'tarquinn/condition/action_checker'
    autoload :MethodCaller,  'tarquinn/condition/method_caller'
    autoload :ProcRunner,    'tarquinn/condition/proc_runner'

    class << self
      def method_caller(methods)
        Tarquinn::Condition::MethodCaller.new(methods)
      end

      def action_checker(routes)
        Tarquinn::Condition::ActionChecker.new(routes)
      end
    end

    def check?(_controller)
      raise 'Needs to be implemented in child class'
    end
  end
end
