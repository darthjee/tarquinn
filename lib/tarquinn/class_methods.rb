# frozen_string_literal: true

module Tarquinn
  # @api public
  #
  # Methods added by Tarquinn
  module ClassMethods
    # Creates a redirection rule
    #
    # The rule name defines which method will be called when checking the path of redirection
    #
    # @param redirection [Symbol] Rule name and method with redirection path
    # @param methods [Array<Symbol>] Methods that tell that a redirection should be applied
    # @param block [Proc] block that tells if a the redirection should be applied
    #
    # @return [NilClass,Array] Current registered conditions
    def redirection_rule(redirection, *methods, &block)
      redirector_builder.add_redirection_config(redirection, *methods, block)
    end

    # Attaches a condition to skip a redirection based on route (controller action)
    #
    # When any of the skip rules is met the redirection is skipped
    #
    # @param redirection [Symbol] Rule name to attach the skip condition
    # @param actions [Array<Symbol>] Route actions to be skipped
    #
    # @return [NilClass,Array] Current registered conditions
    def skip_redirection(redirection, *actions)
      redirector_builder.add_skip_action(redirection, *actions)
    end

    # Attaches conditions to skip a redirection
    #
    # Methods and blocks are ran and if any returns true, the redirec is skipped
    #
    # @param redirection [Symbol] Rule name to attach the skip condition
    # @param methods [Array<Symbol>] Methods that tell that a redirection should be skipped
    # @param block [Proc] block that tells if a the redirection should be skipped
    def skip_redirection_rule(redirection, *methods, &block)
      redirector_builder.add_skip_config(redirection, *methods, block)
    end

    # Retruns the Engine Builder
    #
    # Engine Builder will Carry all the configurations and will create
    # one {Engine} for each request
    #
    # @return [Builder]
    def redirector_builder
      @redirector_builder ||= Tarquinn::Builder.new
    end
  end
end
