# frozen_string_literal: true

require 'logger'
require 'active_support'
require 'active_support/core_ext'

# @api public
#
# Concern adding methods for easy redirection controll
module Tarquinn
  extend ActiveSupport::Concern

  autoload :Version,               'tarquinn/version'
  autoload :RedirectionHandler,    'tarquinn/redirection_handler'
  autoload :Controller,            'tarquinn/controller'
  autoload :Condition,             'tarquinn/condition'
  autoload :RedirectionConfig,     'tarquinn/redirection_config'
  autoload :RequestHandler,        'tarquinn/request_handler'
  autoload :RequestHandlerBuilder, 'tarquinn/request_handler_builder'

  require 'tarquinn/class_methods'

  # @method self.redirection_rule(redirection, *methods, &block)
  #
  # Creates a redirection rule
  #
  # The rule name defines which method will be called when checking the path of redirection
  #
  # @param (see Tarquinn::ClassMethods#redirection_rule)
  # @return (see Tarquinn::ClassMethods#redirection_rule)

  # @method self.skip_redirection(redirection, *actions)
  #
  # Attaches a condition to skip a redirection based on route (controller action)
  #
  # When any of the skip rules is met the redirection is skipped
  #
  # @param (see Tarquinn::ClassMethods#skip_redirection)
  # @return (see Tarquinn::ClassMethods#skip_redirection)

  # @method self.skip_redirection_rule(redirection, *methods, &block)
  #
  # Attaches conditions to skip a redirection
  #
  # Methods and blocks are ran and if any returns true, the redirec is skipped
  #
  # @param (see Tarquinn::ClassMethods#skip_redirection)
  # @return (see Tarquinn::ClassMethods#skip_redirection)

  # @method self.redirector_builder
  #
  # Retruns the RequestHandlerBuilder
  #
  # RequestHandlerBuilder will Carry all the configurations and will create
  # one {RequestHandler} for each request
  #
  # @return (see Tarquinn::ClassMethods#redirector_builder)
  included do
    before_action :perform_redirection
  end

  private

  # @api private
  # private
  #
  # @return [Tarquinn::RequestHandler] an engine for the controller
  def redirector_engine
    self.class.redirector_builder.build(self)
  end

  # Performs redirection if enabled / needed
  #
  # The rules / configuratons are processed in order
  # and if any is positive, it will be processed
  #
  # @return (see Tarquinn::RequestHandler#perform_redirect)
  def perform_redirection
    redirector_engine.perform_redirect
  end
end
