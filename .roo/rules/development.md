# Development Rules (development.md)

This document lists the minimum development rules to follow for this project.

## Overview
Keep the repository healthy by writing tests, following style guidelines, and making small, reviewable changes.

## Environment
- Language: Ruby / Rails
- Use Docker and `docker compose` when appropriate for local parity

## Setup
- Install dependencies: `bundle install`
- Run initial setup: `bin/setup`
- If using containers: `docker compose up`

## Coding and Tests
- Add or update tests for all changes
- Ensure all tests pass locally before committing
- Run static analysis and security checks (RuboCop, brakeman, bundler-audit, etc.)

## Commands (examples)
- Using Docker Compose (examples):
  - Start services (detached): `docker compose up -d`
  - Run a one-off command in the web service (tests):
    - `docker compose exec -it app bundle exec rspec`
  - Run RuboCop inside the web service container:
    - `docker compose exec -it app bundle exec rubocop`
  - Run Rails console in container:
    - `docker compose exec -it app bundle exec rails c`


## Commits and Branching
- Make small, focused commits with clear messages
- Branch naming: `feature/*`, `fix/*`, `chore/*`, etc.

## Pull Requests
- Create PRs with passing CI and tests
- Require at least one reviewer before merging
- Describe intent and important implementation details in the PR body

## Documentation
- Update README or design documents in `plans/` when behavior or APIs change

## Tooling
- Keep RuboCop and other linters configured and green
- Run security and dependency checks regularly

## Notes
- Add project-specific conventions here as the project evolves

## Code Guidelines
- Favor Value Objects and Entities for domain data and modeling.
- Keep mutation and operation logic out of models where appropriate; centralize business operations in Service classes (e.g., app/services).
- Keep Services thin and focused: each Service should perform a single use-case or operation.

