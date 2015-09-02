class Tarquinn::Handler
  attr_accessor :config, :controller

  delegate :redirection_blocks, :skip_blocks, to: :config

  def initialize(config, controller)
    @config = config
    @controller = controller
  end

  def perform_redirect?
    return @perform_redirect unless @perform_redirect.nil?
    @perform_redirect = is_redirect?
  end

  def redirect
    controller.call(:redirect_to, redirect_path)
  end

  private

  def redirect_method
    config.redirect
  end

  def redirect_path
    return redirect_method unless controller.has_method?(redirect_method)
    controller.call redirect_method
  end

  def is_redirect?
    return false if blocks_skip_redirect?
    blocks_require_redirect?
  end

  def blocks_skip_redirect?
    check_blocks(skip_blocks)
  end

  def blocks_require_redirect?
    check_blocks(redirection_blocks)
  end

  def check_blocks(blocks)
    blocks.any? do |block|
      block.yield(controller)
    end
  end
end
