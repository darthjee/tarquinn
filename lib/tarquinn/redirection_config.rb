# frozen_string_literal: true

module Tarquinn
  # @api private
  #
  # Redirection configuration
  #
  # @see Tarquinn::RequestHandler
  class RedirectionConfig
    attr_reader :redirect

    # @param redirect [Symbol] redirection name and redirection method
    def initialize(redirect)
      @redirect = redirect
    end

    # Adds conditions to the rule
    #
    # The rule name defines which method will be called when checking the path of redirection
    #
    # @param methods [Array<Symbol>] Methods that tell that a redirection should be applied
    # @param & [Proc] block that tells if a the redirection should be applied
    #
    # @return [NilClass] When no block is given
    # @return [Array<Tarquinn::Condition>] Current registered conditions
    def add_redirection_rules(*methods, &)
      redirection_blocks << method_caller(methods)
      redirection_blocks << Tarquinn::Condition::ProcRunner.new(&) if block_given?
    end

    # Add rule for skipping on some actions / routes
    #
    # @param routes [Array<Symbol>] actions / routes to be skipped by redirection rule
    #
    # @return [Array<Tarquinn::Condition>]
    def add_skip_action(*routes)
      skip_blocks << action_checker(routes)
    end

    # Attaches conditions to skip a redirection
    #
    # Methods and blocks are ran and if any returns true, the redirec is skipped
    #
    # @param methods [Array<Symbol>] Methods that tell that a redirection should be skipped
    # @param block [Proc] block that tells if a the redirection should be skipped
    #
    # @return [NilClass] When no block is given
    # @return [Array] Current registered conditions
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
