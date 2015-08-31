class Tarquinn::Engine
  attr_reader :configs, :controller

  def initialize(configs, controller)
    @configs = configs
    @controller = controller
  end

  def perform_redirect
    return unless perform_redirect?
    handlers.find { |h| h.perform_redirect? }.redirect
  end

  private

  def perform_redirect?
    handlers.any? { |h| h.perform_redirect? }
  end

  def handlers
    @handlers ||= build_handlers
  end

  def build_handlers
    configs.map { |_,c| Tarquinn::Handler.new(c, controller) }
  end
end
