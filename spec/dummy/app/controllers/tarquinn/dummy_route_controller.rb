# frozen_string_literal: true

module Tarquinn
  class DummyRouteController < ApplicationController
    include Tarquinn

    redirection_rule :redirection_path, :should_redirect?

    def index
    end

    private

    def redirection_path
      '/path'
    end

    def should_redirect?
      params[:should_redirect]
    end
  end
end
