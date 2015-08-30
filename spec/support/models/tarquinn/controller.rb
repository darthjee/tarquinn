class Tarquinn::Controller
  def self.before_action(_)
  end

  include Tarquinn

  redirection_rule :redirection_path, :should_redirect?
  skip_redirection_rule :redirection_path, :should_skip_redirect?

  def parse_request
    perform_redirection
  end

  private

  def redirection_path
    '/path'
  end

  def redirect_to(_)
  end

  def should_redirect?
    true
  end

  def should_skip_redirect?
    false
  end
end
