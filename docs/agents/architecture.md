# Architecture

## Overview

Tarquinn is a Ruby gem: an `ActiveSupport::Concern` that adds a `before_action :perform_redirection` and a class-level DSL (`redirection_rule`, `skip_redirection`, `skip_redirection_rule`) to Rails controllers.

## Source Code Layout

All source lives under `lib/`; `lib/tarquinn.rb` is the concern.

### `lib/tarquinn/`

- `class_methods.rb` – DSL methods added to controllers.
- `request_handler_builder.rb` / `redirection_config_builder.rb` – accumulate redirection configs per controller class.
- `request_handler.rb` – processes a request, finding the first matching redirect.
- `redirection_handler.rb` – evaluates one config (conditions + skip rules).
- `redirection_config.rb`, `redirection_config/options.rb` – data for one rule.
- `condition.rb`, `condition/` (`action_checker`, `method_caller`, `proc_runner`) – condition evaluation.
- `controller.rb` – thin wrapper around the Rails controller.
- `exception.rb`, `version.rb`.
