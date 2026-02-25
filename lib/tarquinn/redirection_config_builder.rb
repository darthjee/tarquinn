# frozen_string_literal: true

module Tarquinn
  class RedirectionConfigBuilder < Sinclair::Model
    initialize_with :configs, :redirection, :methods, :block
  end
end