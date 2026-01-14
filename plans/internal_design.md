# Internal Design: Components, Classes, Sequences

File: [`plans/internal_design.md`](plans/internal_design.md:1)

## Architectural Principles

- Lightweight DDD: use Value Objects and Entities for core domain concepts (Table, Column, Schema).
- Keep side-effecting operations in small, well-defined adapters (file IO, parsing). No large monolithic Executors.
- RSpec for tests, RuboCop for style, GitHub Actions for CI.

## Core Domain Model

- Value Objects
  - TableName
  - ColumnName
  - ColumnType

- Entities
  - Column (name, type, null, default, comment)
  - Table (name, columns[])
  - Schema (tables[])

## Components / Adapters

- MigrationParser (adapter): parses migration files to produce Table/Column entities.
- ModelInspector (adapter): introspects ActiveRecord models to augment or override column metadata.
- SchemaMerger (domain service): merges data from MigrationParser and ModelInspector into canonical Schema.
- MarkdownGenerator (adapter): converts Schema into Markdown string(s).
- FileWriter (adapter): writes Markdown to disk according to configuration.
- Config (value object): encapsulates output path, formats, include/exclude tables.

## Sequence: Rake Task Generate

1. Load config
2. Run MigrationParser -> partial Schema
3. Run ModelInspector -> partial Schema
4. SchemaMerger combine
5. MarkdownGenerator produce markdown
6. FileWriter write file

## Sequence: Migration After Hook

- After migration completes, invoke the same sequence but skip heavy model inspection if in CI.

## File Structure Proposal

- lib/rails_table_doc/
  - version.rb
  - config.rb
  - parsers/
    - migration_parser.rb
    - model_inspector.rb
  - domain/
    - table.rb
    - column.rb
    - schema.rb
  - generators/
    - markdown_generator.rb
  - tasks/
    - rake_tasks.rb
  - adapters/
    - file_writer.rb

## Next Steps

- Start implementing Config and Domain Value Objects.
- Create Rake task scaffolding and a basic MarkdownGenerator for proof of concept.
