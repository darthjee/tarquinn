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
[https://www.rubydoc.info/gems/tarquinn/0.3.0](https://www.rubydoc.info/gems/tarquinn/0.3.0)

This gem makes easier to controll generic redirection

Current Release: [0.3.0](https://github.com/darthjee/tarquinn/tree/0.3.0)

[Next release](https://github.com/darthjee/tarquinn/compare/0.3.0...master)

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

---

## Developer Guide

### How It Works

Tarquinn is a Rails concern that adds a `before_action` to any controller it is included in.
On each request the action chain works as follows:

1. `before_action :perform_redirection` is triggered automatically.
2. A `RequestHandlerBuilder` (stored per controller class) holds all registered redirection
   configs (`redirection_rule` / `skip_redirection` / `skip_redirection_rule` calls).
3. At request time, `RequestHandlerBuilder` creates a `RequestHandler` for the current request.
4. `RequestHandler` iterates over every `RedirectionConfig` and checks whether a redirect
   should fire via `RedirectionHandler`.
5. `RedirectionHandler` evaluates skip conditions first; if none match, it evaluates redirect
   conditions. The first config that requires a redirect triggers `redirect_to`.

### Running Locally with Docker Compose

> Prerequisites: Docker and Docker Compose installed.

**Build the image**

```bash
docker compose build base_build
# or
make build
```

**Run the test suite**

```bash
docker compose run --rm tarquinn /bin/bash -c 'rspec'
# or
make test
```

**Run the full CI-equivalent check suite** (tests + YARD coverage)

```bash
docker compose run --rm test_all
# or
make test_all
```

**Open an interactive shell inside the container**

```bash
docker compose run --rm tarquinn /bin/bash
# or
make dev
```

**View container logs**

```bash
docker compose logs -f
# or
make logs
```

**Stop all containers**

```bash
docker compose down
# or
make stop
```

### Makefile Targets

| Target          | Description                                              |
|-----------------|----------------------------------------------------------|
| `make build`    | Build the Docker image                               |
| `make dev`      | Open an interactive bash shell inside the container  |
| `make test`     | Run RSpec tests inside the container                 |
| `make rubocop`  | Run RuboCop lint checks inside the container         |
| `make test_all` | Run the full CI check suite (tests + YARD coverage)  |
| `make stop`     | Stop all running containers                          |
| `make logs`     | Tail container logs                                  |

### CI Checks

The CircleCI pipeline (`.circleci/config.yml`) runs three jobs:

| Job                   | What it does                                                                             |
|-----------------------|------------------------------------------------------------------------------------------|
| `test`                | `bundle exec rspec` + uploads coverage report                                            |
| `checks`              | RuboCop, Yardstick coverage, README version check, RubyCritic, unit-test structure check |
| `build-and-release`   | Builds and pushes the gem (tags only, on `master`)                                       |

Run the same checks locally before opening a PR:

```bash
# Tests
bundle exec rspec

# RuboCop
bundle exec rubocop

# YARD documentation coverage
bundle exec rake verify_measurements
```
