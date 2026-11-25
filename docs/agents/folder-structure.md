# Folder Structure

## Project Root

| Directory / File | Description |
|---|---|
| `lib/` | Gem source code (`tarquinn.rb` entry point and `tarquinn/` internals). |
| `spec/` | RSpec suite: unit specs in `lib/`, shared examples in `support/`, and a Rails `dummy/` app for integration. |
| `config/` | Quality-tool configs (check_specs, rubycritic, yardstick). |
| `docs/agents/` | Agent-facing docs: architecture, flow, issues, plans. |
| `.github/` | PR/commit templates, Copilot usage notes. |
| `.circleci/` | CI pipeline. |
| `tarquinn.gemspec`, `Gemfile`, `Rakefile` | Gem packaging and tasks. |
| `Dockerfile`, `docker-compose.yml`, `Makefile` | Dev/test container tooling. |
