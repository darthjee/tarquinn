class Tarquinn::ProcRunner
  require 'tarquinn/proc_runner/action_checker'

  delegate :yield, to: :@block

  def initialize(&block)
    @block = block
  end
end
