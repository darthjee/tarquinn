# frozen_string_literal: true

module Tarquinn
  # @api private
  #
  # Redirection configuration
  #
  # @see Tarquinn::RequestHandler
  class RedirectionConfig
    # @api public
    #
    # Redirection name and method that returns the path to redirect to
    #
    # @return [Symbol]
    attr_reader :redirect

    # Initializes a new redirection configuration
    #
    # @param redirect [Symbol] redirection name and redirection method
    #
    # @return [Tarquinn::RedirectionConfig]
    def initialize(redirect)
      @redirect = redirect
    end

    # Adds conditions to the rule
    #
    # The rule name defines which method will be called when checking the path of redirection
    #
    # @param methods [Array<Symbol>] Methods that tell that a redirection should be applied
    # @param block [Proc] block that tells if a the redirection should be applied
    #
    # @return [Array<Tarquinn::Condition>] Current registered conditions
    def add_redirection_rules(*methods, &block)
      redirect_on method_caller(methods)
      redirect_on proc_runner(&block)
    end

    # Add rule for skipping on some actions / routes
    #
    # @param actions [Array<Symbol>] actions / routes to be skipped by redirection rule
    #
    # @return [Array<Tarquinn::Condition>]
    def add_skip_action(*actions)
      skip action_checker(actions)
    end

    # Attaches conditions to skip a redirection
    #
    # Methods and blocks are ran and if any returns true, the redirect is skipped
    #
    # @param methods [Array<Symbol>] Methods that tell that a redirection should be skipped
    # @param block [Proc] block that tells if a the redirection should be skipped
    #
    # @return [Array] Current registered conditions
    def add_skip_rules(*methods, &block)
      skip method_caller(methods)
      skip proc_runner(&block)
    end

    # All blocks that indicate a redirection
    #
    # @return [Array<Tarquinn::Condition>]
    def redirection_blocks
      @redirection_blocks ||= []
    end

    # All blocks that indicate a redirection should be skipped
    #
    # @return [Array<Tarquinn::Condition>]
    def skip_blocks
      @skip_blocks ||= []
    end

    private

    delegate :method_caller, :action_checker, :proc_runner, to: Tarquinn::Condition, private: true

    # @api private
    # @private
    #
    # Adds a condition to skip a redirection
    #
    # @return (see #skip_blocks)
    def skip(condition)
      return skip_blocks unless condition

      skip_blocks << condition
    end

    # @api private
    # @private
    #
    # Adds a condition to a redirection
    #
    # @return (see #redirection_blocks)
    def redirect_on(condition)
      return redirection_blocks unless condition

      redirection_blocks << condition
    end
  end
end
