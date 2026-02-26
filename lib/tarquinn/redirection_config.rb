# frozen_string_literal: true

module Tarquinn
  # @api private
  #
  # Redirection configuration
  #
  # @see Tarquinn::RequestHandler
  class RedirectionConfig < Class.new(Sinclair::Model) { initialize_with :redirection, writter: false }
    autoload :Options, 'tarquinn/redirection_config/options'

    # @method redirection
    # @api private
    #
    # Redirection name and method that returns the path to redirect to
    #
    # @return [Symbol]

    # Initializes a new redirection configuration
    #
    # @param redirection [Symbol] redirection name and redirection method
    #
    # @return [Tarquinn::RedirectionConfig]
    def initialize(redirection:, **options)
      super(redirection:)
      @options = Options.new(**options)
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

    # @method method_caller(methods)
    # @api private
    # @private
    #
    # Creates a method caller condition
    #
    # @see Tarquinn::Condition.method_caller
    # @param (see Tarquinn::Condition.method_caller)
    # @return (see Tarquinn::Condition.method_caller)

    # @method action_checker(routes)
    # @api private
    # @private
    #
    # Creates an action checker condition
    #
    # @see Tarquinn::Condition.action_checker
    # @param (see Tarquinn::Condition.action_checker)
    # @return (see Tarquinn::Condition.action_checker)

    # @method proc_runner(&block)
    # @api private
    # @private
    #
    # Creates a proc runner condition
    #
    # @see Tarquinn::Condition.proc_runner
    # @param (see Tarquinn::Condition.proc_runner)
    # @return (see Tarquinn::Condition.proc_runner)

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
