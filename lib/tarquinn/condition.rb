# frozen_string_literal: true

module Tarquinn
  # @api private
  #
  # Redirection condition
  class Condition
    require 'tarquinn/condition/action_checker'
    require 'tarquinn/condition/method_caller'
    require 'tarquinn/condition/proc_runner'

    def check?(controller)
      raise "Needs to be implemented in child class"
    end
  end
end
