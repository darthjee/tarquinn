# frozen_string_literal: true

module Tarquinn
  class Controller
    attr_reader :controller

    def initialize(controller)
      @controller = controller
    end

    def params
      @params ||= controller.send(:params)
    end

    def call(method, *args)
      controller.send(method, *args)
    end

    def has_method?(method)
      controller.respond_to?(method, true)
    end
  end
end
