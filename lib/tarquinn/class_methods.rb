# frozen_string_literal: true

module Tarquinn
  # @api public
  #
  # Methods added by Tarquinn
  module ClassMethods
    def skip_redirection(redirection, *actions)
      redirector_builder.add_skip_action(redirection, *actions)
    end

    def redirection_rule(redirection, *methods, &block)
      redirector_builder.add_redirection_config(redirection, *methods, block)
    end

    def skip_redirection_rule(redirection, *methods, &block)
      redirector_builder.add_skip_config(redirection, *methods, block)
    end

    def redirector_builder
      @redirector_builder ||= Tarquinn::Builder.new
    end
  end
end
