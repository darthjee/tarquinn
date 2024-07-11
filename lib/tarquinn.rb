# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext'

# @api public
#
# Concern adding methods for easy redirection controll
module Tarquinn
  require 'tarquinn/version'
  require 'tarquinn/handler'
  require 'tarquinn/controller'
  require 'tarquinn/condition'
  require 'tarquinn/config'
  require 'tarquinn/engine'
  require 'tarquinn/builder'
  require 'tarquinn/class_methods'
  require 'tarquinn/concern'
end
