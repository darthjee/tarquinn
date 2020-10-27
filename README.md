Tarquinn
========
[![Build Status](https://circleci.com/gh/darthjee/tarquinn.svg?style=shield)](https://circleci.com/gh/darthjee/tarquinn)
[![Code Climate](https://codeclimate.com/github/darthjee/tarquinn/badges/gpa.svg)](https://codeclimate.com/github/darthjee/tarquinn)
[![Test Coverage](https://codeclimate.com/github/darthjee/tarquinn/badges/coverage.svg)](https://codeclimate.com/github/darthjee/tarquinn/coverage)
[![Issue Count](https://codeclimate.com/github/darthjee/tarquinn/badges/issue_count.svg)](https://codeclimate.com/github/darthjee/tarquinn)
[![Gem Version](https://badge.fury.io/rb/tarquinn.svg)](https://badge.fury.io/rb/tarquinn)
[![Inline docs](http://inch-ci.org/github/darthjee/tarquinn.svg)](http://inch-ci.org/github/darthjee/tarquinn)

![tarquinn](https://raw.githubusercontent.com/darthjee/tarquinn/master/tarquinn.jpg)

Yard Documentation
-------------------
[https://www.rubydoc.info/gems/tarquinn/0.2.0](https://www.rubydoc.info/gems/tarquinn/0.2.0)

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
