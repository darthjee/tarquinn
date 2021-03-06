class Tarquinn::Builder
  def add_skip_action(redirection, *actions)
    config_for(redirection).add_skip_action(*actions)
  end

  def add_redirection_config(redirection, *methods, block)
    config_for(redirection).add_redirection_rules(*methods, &block)
  end

  def add_skip_config(redirection, *methods, block)
    config_for(redirection).add_skip_rules(*methods, &block)
  end

  def build(controller)
    controller = Tarquinn::Controller.new(controller)
    Tarquinn::Engine.new(configs, controller)
  end

  private

  def config_for(redirection)
    configs[redirection.to_sym] ||= Tarquinn::Config.new(redirection)
  end

  def configs
    @configs ||= {}
  end
end
