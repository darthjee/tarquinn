class Tarquinn::ProcRunner::MethodCaller < Tarquinn::ProcRunner
  attr_accessor :methods

  def initialize(methods)
    @methods = [ methods ].flatten

    super(&build_block)
  end

  private

  def build_block
    Proc.new do |controller|
      self.methods.any? do |method|
        controller.call(method)
      end
    end
  end
end
