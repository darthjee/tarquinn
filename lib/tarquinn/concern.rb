module Tarquinn
  extend ActiveSupport::Concern

  included do
    before_action :perform_redirection
  end

  private

  def redirector_engine
    self.class.redirector_builder.build(self)
  end

  def perform_redirection
    redirector_engine.perform_redirect
  end
end
