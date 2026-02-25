# frozen_string_literal: true

module Tarquinn
  class RedirectionConfigBuilder < Sinclair::Model
    initialize_with :configs, :redirection

    def self.build(**attributes, &block)
      new(**attributes).build(&block)
    end

    def build(&block)
      check_redirection_exists!

      config.tap(&block)
    end

    private

    def config
      configs[redirection.to_sym] = Tarquinn::RedirectionConfig.new(redirection)
    end

    def check_redirection_exists!
      raise Exception::RedirectionAlreadyDefined, redirection if config_exists?
    end

    def config_exists?
      configs[redirection.to_sym]
    end
  end
end
