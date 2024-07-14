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

    def should_skip?
      params[:should_skip]
    end

    def always_redirect
      true
    end
  end
end
