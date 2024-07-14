# frozen_string_literal: true

module Tarquinn
  # @api private
  #
  # Controller interface
  class Controller
    def initialize(controller)
      @controller = controller
    end

    def params
      @params ||= controller.send(:params)
    end

    def call(method, *)
      controller.send(method, *)
    end

    def method?(method)
      controller.respond_to?(method, true)
    end

    private

    attr_reader :controller
  end
end
