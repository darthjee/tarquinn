# frozen_string_literal: true

module Tarquinn
  # @api public
  #
  # Methods added by Tarquinn
  module ClassMethods
    # Creates a redirection rule
    #
    # The rule name defines which method will be called when checking the path of redirection
    #
    # @param (see Tarquinn::RequestHandlerBuilder#add_redirection_config)
    # @return (see Tarquinn::RequestHandlerBuilder#add_redirection_config)
    #
    # @example A redirection with block style condition
    #   class ApplicationController < ActionController::Base
    #     include Tarquinn
    #
    #     redirection_rule :redirect_old_path do |redirection|
    #       redirection.path == '/old_path'
    #     end
    #
    #     private
    #
    #     def redirect_old_path
    #       '/new_path'
    #     end
    #   end
    #
    # @example A redirection with method style condition
    #   class ApplicationController < ActionController::Base
    #     include Tarquinn
    #
    #     redirection_rule :redirect_old_path, :perform_redirection_for_old_path?
    #
    #     private
    #
    #     def perform_redirection_for_old_path?
    #       request.path == '/old_path'
    #     end
    #
    #     def redirect_old_path
    #       '/new_path'
    #     end
    #   end
    def redirection_rule(redirection, *methods, &)
      redirector_builder.add_redirection_config(redirection, *methods, &)
    end

    # Attaches a condition to skip a redirection based on route (controller action)
    #
    # When any of the skip rules is met the redirection is skipped
    #
    # @param (see Tarquinn::RequestHandlerBuilder#add_skip_action)
    # @return (see Tarquinn::RequestHandlerBuilder#add_skip_action)
    def skip_redirection(redirection, *actions)
      redirector_builder.add_skip_action(redirection, *actions)
    end

    # Attaches conditions to skip a redirection
    #
    # Methods and blocks are ran and if any returns true, the redirect is skipped
    #
    # @param (see Tarquinn::RequestHandlerBuilder#add_skip_config)
    # @return (see Tarquinn::RequestHandlerBuilder#add_skip_config)
    #
    # @example A redirection with method style condition
    #   class ApplicationController < ActionController::Base
    #     include Tarquinn
    #
    #     redirection_rule :redirect_old_path
    #     skip_redirection_rule :redirect_old_path, :skip_redirection_for_old_path?
    #
    #     private
    #
    #     def skip_redirection_for_old_path?
    #       request.path != '/old_path'
    #     end
    #
    #     def redirect_old_path
    #       '/new_path'
    #     end
    #   end
    #
    # @example A redirection with block style condition
    #   class ApplicationController < ActionController::Base
    #     include Tarquinn
    #
    #     redirection_rule :redirect_old_path do |redirection|
    #       redirection.path == '/old_path'
    #     end
    #
    #     private
    #
    #     def redirect_old_path
    #       '/new_path'
    #     end
    #   end
    def skip_redirection_rule(redirection, *methods, &block)
      redirector_builder.add_skip_config(redirection, *methods, &block)
    end

    # Returns the RequestHandlerBuilder
    #
    # RequestHandlerBuilder will carry all the configurations and will create
    # one {RequestHandler} for each request
    #
    # @return [RequestHandlerBuilder]
    def redirector_builder
      @redirector_builder ||= Tarquinn::RequestHandlerBuilder.new
    end
  end
end
