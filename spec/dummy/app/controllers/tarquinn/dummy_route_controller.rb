# frozen_string_literal: true

module Tarquinn
  class DummyRouteController < ApplicationController
    include Tarquinn

    def index; end

    def new; end

    private

    def redirection
      '/path'
    end

    def should_redirect?
      params[:should_redirect]
    end

    def always_redirect
      true
    end
  end
end
