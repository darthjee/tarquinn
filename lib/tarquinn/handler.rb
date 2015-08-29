class Tarquinn::Handler
  attr_accessor :config, :controller

  delegate :methods, :skip_methods, :blocks, :skip_blocks, to: :config

  def initialize(config, controller)
    @config = config
    @controller = controller
  end

  def perform_redirect?
    @perform_redirect = is_redirect? if @perform_redirect.nil?
    @perform_redirect
  end

  def redirect
    controller.send(:redirect_to, redirect_path)
  end

  private

  def redirect_method
    config.redirect
  end

  def redirect_path
    controller.send(config.redirect)
  end

  def is_redirect?
    return false if methods_skip_redirect? || blocks_skip_redirect?
    methods_require_redirect? || blocks_require_redirect?
  end

  def methods_skip_redirect?
    skip_methods.any? do |method|
      controller.send(method)
    end
  end

  def blocks_skip_redirect?
    skip_blocks.any? do |block|
      block.yield
    end
  end

  def methods_require_redirect?
    methods.any? do |method|
      controller.send(method)
    end
  end

  def blocks_require_redirect?
    blocks.any? do |block|
      block.yield
    end
  end
end
