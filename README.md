Tarquinn
========

This gem makes easier to controll generic redirection

Getting started
---------------
1. Add Tarquinn to your `Gemfile` and `bundle install`:

  ```ruby
    gem 'tarquinn'
  ```

2. Include Tarquinn to your controller or to your base controller
  ```ruby
    ApplicationController < ActionController::Base
      include Tarquinn
    end
  ```

3. Program your redirection on your controllers
  ```ruby
    BaseController < ApplicationController
      redirection_rule :redirect_login, :loggin_needed?

      private

      def redirect_login
        login_path
      end

      def loggin_needed?
        user.nil?
      end
    end

    StaticController < BaseController
      skip_redirection_rule :redirect_login, :is_home?

      private

      def is_home?
        params[:action] == 'home'
      end
    end
  ```
