class Tarquinn::ProcRunner::ActionChecker < Tarquinn::ProcRunner
  def initialize(routes)
    routes = [ routes ].flatten.map(&:to_s)
    super() do |controller|
      routes.include? controller.params[:action]
    end
  end
end
