# frozen_string_literal: true

module Tarquinn
  class DummyRouteController < ApplicationController
    include Tarquinn

    redirection_rule :redirection, :should_redirect?

    def index
    end

    private

    def redirection
      '/path'
    end

    def should_redirect?
      params[:should_redirect]
    end
  end
end
