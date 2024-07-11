# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext'

# @api public
#
# Concern adding methods for easy redirection controll
module Tarquinn
  extend ActiveSupport::Concern

  require 'tarquinn/version'
  require 'tarquinn/handler'
  require 'tarquinn/controller'
  require 'tarquinn/condition'
  require 'tarquinn/config'
  require 'tarquinn/engine'
  require 'tarquinn/builder'
  require 'tarquinn/class_methods'

  included do
    before_action :perform_redirection
  end

  private

  def redirector_engine
    self.class.redirector_builder.build(self)
  end

  def perform_redirection
    redirector_engine.perform_redirect
  end
end
