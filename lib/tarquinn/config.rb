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
      skip_blocks << block_routes(routes)
    end

    def add_redirection_rules(*methods, &)
      redirection_blocks << block_methods(methods)
      redirection_blocks << Tarquinn::Condition::ProcRunner.new(&) if block_given?
    end

    def add_skip_rules(*methods, &)
      skip_blocks << block_methods(methods)
      skip_blocks << Tarquinn::Condition::ProcRunner.new(&) if block_given?
    end

    def redirection_blocks
      @redirection_blocks ||= []
    end

    def skip_blocks
      @skip_blocks ||= []
    end

    private

    def block_methods(methods)
      Tarquinn::Condition::MethodCaller.new(methods)
    end

    def block_routes(routes)
      Tarquinn::Condition::ActionChecker.new(routes)
    end
  end
end
