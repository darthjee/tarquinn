# frozen_string_literal: true

module Tarquinn
  class RedirectionConfigBuilder < Sinclair::Model
    initialize_with :configs, :redirection, :methods, :block

    def self.build(...)
    end

    def build
      create_config do |config|
        config.add_redirection_rules(*methods, &block)
      end
    end

    private

    def create_config
      raise Exception::RedirectionAlreadyDefined, redirection if configs[redirection.to_sym]

      config = configs[redirection.to_sym] = Tarquinn::RedirectionConfig.new(redirection)

      config.tap(&block)
    end
  end
end