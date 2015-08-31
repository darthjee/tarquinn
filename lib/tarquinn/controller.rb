class Tarquinn::ParamsHandler
  attr_reader :controller

  def initialize(controller)
    @controller = controller
  end

  def params
    @params ||= controller.send(:params)
  end

  def call(method)
    controller.send(method)
  end
end