# Contributing

## Commit Guidelines

- **Atomic and Unitary:** Each commit must represent a single logical change.
  *Example:*
  - Good: `Add needs_params? method to RedirectionConfig`
  - Bad: `Add needs_params? and refactor RequestHandler logic`
- **No Unrelated Changes:** Do not mix unrelated changes in the same commit.
- **Separate Refactoring:** Whenever possible, separate refactoring commits from new feature or bugfix commits.

## Pull Requests

- **Descriptive Summary:** Every PR must include a clear and descriptive summary of its purpose and changes.
- **PR Description Files:** If a description cannot be provided directly in the PR, generate a file with the PR description (e.g., `docs/issues/<pr_number>_description.md`), but do not commit this file.

## Definition of Done for PRs

A PR is considered complete when:

- The stated objective has been achieved.
- All tests are passing.
- Linting passes without errors.
- Code coverage is as high as reasonably possible.
- Code is not overly complex:
  - Classes and methods should have clear, focused responsibilities.
  - If a class or method is taking on too many responsibilities, refactor to simplify.
  - Methods should be small and do exactly one thing. If a method is growing, extract parts into private helper methods or separate classes.
  - *Example:*

    ```ruby
    # Good: Each method does one thing
    class Worker
      def fetch_job; end
      def process_job(job); end
    end

    # Bad: Method does too much
    class Worker
      def run
        fetch_job
        process_job
        send_metrics
        cleanup
      end
    end
    ```

  - This requirement applies primarily to source code. For specs, refactor only if there is excessive duplication.

### CI Checks

Before a PR is considered complete, all CI checks relevant to the modified parts of the project must pass locally. The project is a single gem, so both CircleCI jobs apply to any change under `lib/`, `spec/` or `config/`:

| Job | Local commands |
| --- | --- |
| `test` | `bundle exec rspec` |
| `checks` | `rubocop`, `bundle exec rake verify_measurements` (Yardstick), `check_readme.sh`, `rubycritic.sh`, `check_specs` |

Development and test containers are available via `make dev` and `make tests`.

This same process must be followed when **planning how to resolve an issue**: include a final step in the plan that lists the CI commands to run before opening a PR.

## Code Organization

### File Responsibility: Class Declarers vs Scripts

Every source file (excluding specs) must act as a **class declarer** — it should define one or more classes or modules, and must not execute logic or cause side effects at load time.

The only exception is `lib/tarquinn.rb`, which is the entry point (the `ActiveSupport::Concern` included by controllers) and requires the other files.

*Example:*

```ruby
# Good: class declarer
class Tarquinn::RequestHandler
  def process; end
end

# Bad: script — executes logic at load time
handler = Tarquinn::RequestHandler.new
handler.process
```

Spec files are exempt from this rule.

### File Naming: snake_case for Class Files

Files that define a class must use **snake_case** naming matching the class name, and spec files append `_spec`.

*Examples:*

- `request_handler.rb` for `Tarquinn::RequestHandler`
- `redirection_config.rb` for `Tarquinn::RedirectionConfig`

Specs mirror the source path: `lib/tarquinn/request_handler.rb` → `spec/lib/tarquinn/request_handler_spec.rb`.

### Method Order: Public Before Private

Within a class, **public methods must be declared before private methods**. Private helpers go at the end of the class body, after `private`.

```ruby
# Good
class Worker
  def run
    prepare
    execute
  end

  private

  def prepare; end
  def execute; end
end
```

## Dependency Injection

Classes must receive their dependencies (data, configuration, collaborators) as constructor arguments. A class must never reach out to load files, read environment variables, or fetch configuration on its own.

*Example:*

```ruby
# Good: receives data — easy to test
class Router
  def initialize(data)
    @data = data
  end
end

# Bad: loads its own config
class Router
  def build
    data = YAML.load_file('./data.yml')
  end
end
```

## Refactoring Guidelines

When refactoring, aim to:

- **Reduce Code Duplication:** Move repeated spec setup into `let` definitions or shared examples (`spec/support/shared_examples`).

  ```ruby
  # Good
  let(:category) { build_category(id: 2) }

  # Bad: the same hash repeated in many examples
  ```
