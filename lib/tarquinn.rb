# frozen_string_literal: true

require 'logger'
require 'active_support'
require 'active_support/core_ext'
require 'sinclair'

# @api public
# @author darthjee
#
# Concern adding methods for easy redirection control
#
# @example (see Tarquinn::ClassMethods#redirection_rule)
# @example (see Tarquinn::ClassMethods#skip_redirection_rule)
# @example (see Tarquinn::ClassMethods#skip_redirection)
module Tarquinn
  extend ActiveSupport::Concern

  autoload :Version,                  'tarquinn/version'
  autoload :RedirectionHandler,       'tarquinn/redirection_handler'
  autoload :Controller,               'tarquinn/controller'
  autoload :Condition,                'tarquinn/condition'
  autoload :Exception,                'tarquinn/exception'
  autoload :RedirectionConfig,        'tarquinn/redirection_config'
  autoload :RedirectionConfigBuilder, 'tarquinn/redirection_config_builder'
  autoload :RequestHandler,           'tarquinn/request_handler'
  autoload :RequestHandlerBuilder,    'tarquinn/request_handler_builder'

  require 'tarquinn/class_methods'

  # @method self.redirection_rule(redirection, *methods, &block)
  #
  # Creates a redirection rule
  #
  # The rule name defines which method will be called when checking the path of redirection
  #
  # @example (see Tarquinn::ClassMethods#redirection_rule)
  # @param (see Tarquinn::ClassMethods#redirection_rule)
  # @return (see Tarquinn::ClassMethods#redirection_rule)

  # @method self.skip_redirection(redirection, *actions)
  #
  # Attaches a condition to skip a redirection based on route (controller action)
  #
  # When any of the skip rules is met the redirection is skipped
  #
  # @example (see Tarquinn::ClassMethods#skip_redirection)
  # @param (see Tarquinn::ClassMethods#skip_redirection)
  # @return (see Tarquinn::ClassMethods#skip_redirection)

  # @method self.skip_redirection_rule(redirection, *methods, &block)
  #
  # Attaches conditions to skip a redirection
  #
  # Methods and blocks are ran and if any returns true, the redirect is skipped
  #
  # @example (see Tarquinn::ClassMethods#skip_redirection_rule)
  # @param (see Tarquinn::ClassMethods#skip_redirection_rule)
  # @return (see Tarquinn::ClassMethods#skip_redirection_rule)

  # @method self.redirector_builder
  #
  # Returns the RequestHandlerBuilder
  #
  # RequestHandlerBuilder will carry all the configurations and will create
  # one {RequestHandler} for each request
  #
  # @return (see Tarquinn::ClassMethods#redirector_builder)
  included do
    before_action :perform_redirection
  end

  private

  # @api private
  # @private
  #
  # @return [Tarquinn::RequestHandler] an engine for the controller
  def redirector_engine
    self.class.redirector_builder.build(self)
  end

  # @api private
  # @private
  #
  # Performs redirection if enabled / needed
  #
  # The rules / configurations are processed in order
  # and if any is positive, it will be processed
  #
  # @return (see Tarquinn::RequestHandler#perform_redirect)
  def perform_redirection
    redirector_engine.perform_redirect
  end
end
