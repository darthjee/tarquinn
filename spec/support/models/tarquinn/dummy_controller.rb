# frozen_string_literal: true

module Tarquinn
  class DummyController
    def self.before_action(_)
    end

    include Tarquinn

    skip_redirection :redirection_path, :route_method
    redirection_rule :redirection_path, :should_redirect?
    skip_redirection_rule :redirection_path, :should_skip_redirect?

    def parse_request
      perform_redirection
    end

    private

    def params
      { action: 'show' }
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

    def redirect_to(_)
    end

    def should_redirect?
      true
    end

    def should_skip_redirect?
      false
    end
  end
end
