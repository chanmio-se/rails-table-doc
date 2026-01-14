# Rails Table Doc

Auto table definition documentation generator for Ruby on Rails.

Rails Table Doc is a Gem for automatically generating table documentation for Rails applications. It extracts table and column information from both migration files and Active Record models, and outputs the documentation in Markdown format.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails-table-doc'
```

And then execute:

```bash
$ bundle install
```

## Usage

This Gem can be utilized as a Rake task or integrated with migration's after hook.

### Rake Task

To generate table documentation, run the following Rake task:

```bash
$ rake rails_table_doc:generate
```

Configuration can be managed via a dedicated config file. Details on how to set up the config file will be provided.

### Migration After Hook

To automatically update the table documentation after each migration execution, further instructions will be provided on how to configure this feature.
