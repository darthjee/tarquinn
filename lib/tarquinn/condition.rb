# frozen_string_literal: true

module Tarquinn
  # @api private
  #
  # Runle condition
  module Condition
    require 'tarquinn/condition/action_checker'
    require 'tarquinn/condition/method_caller'
    require 'tarquinn/condition/proc_runner'
  end
end
