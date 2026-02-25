# frozen_string_literal: true

module Tarquinn
  class DummyController < ApplicationController
    include Tarquinn

    redirection_rule :redirection_path, :should_redirect?
    skip_redirection :redirection_path, :route_method
    skip_redirection_rule :redirection_path, :should_skip_redirect?

    def parse_request
      perform_redirection
    end

    private

    def params
      ActionController::Parameters.new({ action: 'show' })
    end

    def true
      true
    end

    def false
      false
    end

    def redirection_path
      '/path'
    end

    def redirect_to(_); end

    def should_redirect?
      true
    end

    def should_skip_redirect?
      false
    end
  end
end
