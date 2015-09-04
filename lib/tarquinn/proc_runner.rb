class Tarquinn::ProcRunner
  require 'tarquinn/proc_runner/method_caller'

  delegate :yield, to: :@block

  def initialize(&block)
    @block = block
  end
end
