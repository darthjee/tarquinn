class Tarquinn::ProcRunner::MethodCaller
  attr_accessor :methods

  def initialize(methods)
    @methods = [ methods ].flatten
  end

  def yield(controller)
    methods.any? do |method|
      controller.call(method)
    end
  end
end
