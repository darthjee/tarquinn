# frozen_string_literal: true

module Tarquinn
  # @api private
  #
  # Redirection configuration
  #
  # @see Tarquinn::RequestHandler
  class Config
    attr_reader :redirect

    def initialize(redirect)
      @redirect = redirect
    end

    def add_skip_action(*routes)
      skip_blocks << action_checker(routes)
    end

    def add_redirection_rules(*methods, &)
      redirection_blocks << method_caller(methods)
      redirection_blocks << Tarquinn::Condition::ProcRunner.new(&) if block_given?
    end

    def add_skip_rules(*methods, &)
      skip_blocks << method_caller(methods)
      skip_blocks << Tarquinn::Condition::ProcRunner.new(&) if block_given?
    end

    def redirection_blocks
      @redirection_blocks ||= []
    end

    def skip_blocks
      @skip_blocks ||= []
    end

    delegate :method_caller, :action_checker, to: Tarquinn::Condition
  end
end
