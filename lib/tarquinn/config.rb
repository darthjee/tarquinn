class Tarquinn::Config
  attr_accessor :redirect

  def initialize(redirect)
    @redirect = redirect
  end

  def add_skip_route(*routes)
    skip_blocks << block_routes(routes)
  end

  def add_redirection_rules(*methods, &block)
    redirection_blocks << block_methods(methods)
    redirection_blocks << block if block_given?
  end

  def add_skip_rules(*methods, &block)
    skip_blocks << block_methods(methods)
    skip_blocks << block if block_given?
  end

  def redirection_blocks
    @blocks ||= []
  end

  def skip_blocks
    @skip_blocks ||= []
  end

  private

  def block_methods(methods)
    Tarquinn::ProcRunner::MethodCaller.new(methods)
  end

  def block_routes(routes)
    Tarquinn::ProcRunner::ActionChecker.new(routes)
  end
end
