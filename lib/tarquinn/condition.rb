# frozen_string_literal: true

module Tarquinn
  # @api private
  #
  # Redirection condition
  class Condition
    autoload :ActionChecker, 'tarquinn/condition/action_checker'
    autoload :MethodCaller,  'tarquinn/condition/method_caller'
    autoload :ProcRunner,    'tarquinn/condition/proc_runner'

    def check?(controller)
      raise "Needs to be implemented in child class"
    end
  end
end
