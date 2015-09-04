class Tarquinn::ProcRunner
  delegate :yield, to: :@block

  def initialize(&block)
    @block = block
  end
end
