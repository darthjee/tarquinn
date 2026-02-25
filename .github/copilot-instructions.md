# GitHub Copilot Instructions for Tarquinn

## Project Overview

Tarquinn is a Ruby gem that provides generic redirection control for Rails controllers.
It is implemented as an `ActiveSupport::Concern` that adds `before_action` hooks and
class-level DSL methods (`redirection_rule`, `skip_redirection`, `skip_redirection_rule`)
to any Rails controller.

Key components:

- **`Tarquinn`** – The main concern included in controllers; sets up `before_action :perform_redirection`.
- **`Tarquinn::ClassMethods`** – DSL methods added to controller classes.
- **`Tarquinn::RequestHandlerBuilder`** – Accumulates redirection configurations for a controller class.
- **`Tarquinn::RequestHandler`** – Processes a single request, iterating over configs to find the first matching redirect.
- **`Tarquinn::RedirectionHandler`** – Evaluates one redirection config (conditions + skip rules) for a request.
- **`Tarquinn::RedirectionConfig`** – Holds the data for a single redirection rule (blocks, skip blocks, redirect target).
- **`Tarquinn::Condition`** – Wraps a single condition (method name or block) used in redirection/skip evaluation.
- **`Tarquinn::Controller`** – Thin wrapper around the Rails controller instance, used by handlers.

## Redirection Rules Data Flow

### How It Works

1. A controller includes `Tarquinn` (an `ActiveSupport::Concern`), which:
   - Extends the controller with `Tarquinn::ClassMethods`, making the DSL methods available.
   - Registers a `before_action :perform_redirection` that runs on every request.

2. During a request, `perform_redirection` delegates to `Tarquinn::RequestHandler`, which
   iterates over all registered `Tarquinn::RedirectionConfig` objects (in definition order)
   and applies the **first** rule whose conditions are satisfied.

3. Each rule is evaluated by `Tarquinn::RedirectionHandler`:
   - All condition methods and/or the optional block are evaluated against the current
     controller instance.
   - If **any** condition returns a truthy value the rule fires and the controller redirects
     to the path returned by the rule's target method.
   - Skip conditions (registered via `skip_redirection` or `skip_redirection_rule`) are
     checked first; if any skip condition is truthy the rule is bypassed entirely.

### Defining a Redirection Rule — `redirection_rule`

```ruby
redirection_rule <rule_name>, *<condition_methods>, &<block>
```

| Argument            | Description                                                                                  |
|---------------------|----------------------------------------------------------------------------------------------|
| `rule_name`         | Symbol. Also the name of the controller method that returns the redirect path.               |
| `condition_methods` | Zero or more symbol method names. Each is called on the controller; truthy → rule fires.     |
| `block`             | Optional. Evaluated in the context of the controller; truthy → rule fires.                   |

**Evaluation**: the rule fires when **any** condition method **or** the block returns truthy.

#### Example 1 — block-based rule

```ruby
redirection_rule :redirect_home { params[:secret_key] != '12345' }

def redirect_home
  home_path
end
```

Redirects to `home_path` if `secret_key` is absent or different from `'12345'`.

#### Example 2 — method-based rule

```ruby
redirection_rule :redirect_home, :misses_secret_key

def redirect_home
  home_path
end

def misses_secret_key
  params[:secret_key] != '12345'
end
```

Same behaviour as Example 1, but the condition is extracted into a dedicated method.

### Skipping a Rule for Specific Actions — `skip_redirection`

```ruby
skip_redirection <rule_name>, *<actions>
```

Prevents the named rule from running for the listed controller actions.

```ruby
skip_redirection :redirect_home, :index
```

The `index` action is not affected by the `redirect_home` rule; all other actions still are.

### Skipping a Rule Under a Condition — `skip_redirection_rule`

```ruby
skip_redirection_rule <rule_name>, *<condition_methods>, &<block>
```

Registers a skip condition for a rule. When the condition is truthy the rule is bypassed,
regardless of the action.

```ruby
skip_redirection_rule :redirect_home { params[:admin_key] == '9999' }
```

The `redirect_home` rule does not fire when the correct admin key is provided.

## Language

All code, comments, documentation, commit messages, and PR descriptions must be written in **English**.

## Coding Standards

### General Style

- Follow the existing RuboCop configuration (`.rubocop.yml` / `.rubocop_todo.yml`).
- Use `# frozen_string_literal: true` at the top of every Ruby file.
- Keep methods small and focused (Sandi Metz style): aim for methods under 5 lines.
- Keep classes small with clear, single responsibilities and explicit object boundaries.
- Avoid deeply nested conditionals; extract guard clauses or helper methods.
- Use `private` / `attr_reader` to hide implementation details.
- Use `delegate` (ActiveSupport) instead of manual forwarding where it improves readability.

### Documentation

- Add **YARD** documentation to all public classes, modules, and methods.
- Non-obvious private methods should also have short YARD comments.
- Always include `@param`, `@return`, and `@api public` / `@api private` tags where applicable.
- Ensure documentation coverage stays at or above the threshold in `config/yardstick.yml`.

### Tests

- Write **RSpec** tests using the patterns established in `spec/`.
- Keep tests small and focused — one behaviour per example.
- Use `let` definitions that are **reusable** and **avoid duplication** across contexts.
- Prefer `context` blocks to describe different input/state scenarios.
- Avoid `before` blocks that do more than one thing; split them if needed.
- Use `shared_examples` or `shared_context` when the same setup appears in multiple groups.

## CI Checks

The CI pipeline (`.circleci/config.yml`) runs the following checks on every push.
Reproduce them locally before opening a PR:

| CI Step                        | Local Command                                    |
|-------------------------------|--------------------------------------------------|
| Run tests                     | `bundle exec rspec`                              |
| RuboCop lint                  | `bundle exec rubocop`                            |
| YARD documentation coverage   | `bundle exec rake verify_measurements`           |
| RubyCritic quality check      | `rubycritic.sh` (or `bundle exec rubycritic`)    |

All checks must pass before a PR can be merged.

## Docker / Local Development

To run the project locally, use the Makefile targets:

- Build Docker image:  `make build`
- Start development environment:  `make dev`
- Run tests:  `make tests`

See the [Developer Guide](../README.md#developer-guide) in the README for further instructions.
