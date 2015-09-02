class Tarquinn::ProcRunner::ActionChecker < Tarquinn::ProcRunner
  attr_accessor :routes

  def initialize(routes)
    @routes = [ routes ].flatten.map(&:to_s)

    super(&build_block)
  end

  private

  def build_block
    Proc.new do |controller|
      self.routes.include? controller.params[:action]
    end
  end
end
