class Tarquinn::Condition::ProcRunner
  attr_reader :block

  def initialize(&block)
    @block = block
  end

  def check?(controller)
    block.yield(controller)
  end
end
