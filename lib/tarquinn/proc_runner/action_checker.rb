class Tarquinn::ProcRunner::ActionChecker
  attr_accessor :routes

  def initialize(routes)
    @routes = [ routes ].flatten.map(&:to_s)
  end

  def yield(controller)
    routes.include? controller.params[:action]
  end
end
