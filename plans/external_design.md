# External Design: User Stories and Event Storming

File: [`plans/external_design.md`](plans/external_design.md:1)

## Purpose

Explain how rails-table-doc integrates into a Rails project's workflow to keep table documentation up to date.

## Scope

- Source data: migration files and ActiveRecord models.
- Output: Markdown documentation of tables and columns.
- Integration: manual generation via a Rake task and optional automatic update after migrations (opt-in).

## User Stories

- As a developer, I run a single Rake task to generate table documentation.
- As a developer, documentation updates automatically after migrations when enabled.
- As a maintainer, I configure output path and include/exclude rules via a config file.
- As a contributor, code separates domain (Table/Column) from I/O (parsers/generators) for testability.

## Data Flow (updated)

- Extract schema information primarily from migration files.
- Allow migration definitions to contain metadata (e.g., logical names) as arguments for tables and columns.
- Store and manage table metadata as YAML (table info) that can be edited manually and merged with parsed schema.
- Optionally augment or override metadata via ActiveRecord model inspection.

## User Journey (Mermaid)

```mermaid
graph TD
  Developer -->|run rake| RakeTask[Rake: rails_table_doc:generate]
  Developer -->|run db:migrate| Migration[Migration run]
  Migration -->|if enabled| AfterHook[Migration after hook]

  RakeTask --> MigrationParser[Migration Parser]
  RakeTask --> ModelInspector[Model Inspector]

  MigrationParser --> ParsedSchema[Parsed Schema from migrations]
  ModelInspector --> ModelSchema[Schema augmentations from models]
  YAMLStore[Table metadata YAML] --> MergedSchema[Merged Schema]

  ParsedSchema --> MergedSchema
  ModelSchema --> MergedSchema

  MergedSchema --> MarkdownGenerator[Markdown Generator]
  MarkdownGenerator --> FileWriter[File Writer]
  FileWriter --> Documentation[Documentation updated]

  AfterHook --> MigrationParser
```

## Event Storming (Mermaid)

```mermaid
graph TD
  E1[Migration executed] --> E2[Schema changed]
  E2 --> Cmd[Command: generate_docs]

  Cmd --> Step1[Parse migration files extract metadata args]
  Cmd --> Step2[Load table metadata YAML]
  Cmd --> Step3[Inspect ActiveRecord models]

  Step1 --> ParsedEntities[Parsed Table/Column entities]
  Step2 --> YAMLMetadata[Loaded YAML metadata]
  Step3 --> ModelEntities[Model-based entities]

  ParsedEntities --> MergedSchema
  YAMLMetadata --> MergedSchema
  ModelEntities --> MergedSchema

  MergedSchema --> Generate[Generate Markdown]
  Generate --> Out[Write or update file]
  Out --> E3[Documentation updated]
```

## Constraints and Notes

- Migration after hook is opt-in; disable in production environments by default.
- Migration files can contain metadata arguments; define a safe DSL for metadata to avoid eval risks.
- YAML store is the source of truth for human-managed metadata and is merged with parsed schema.
- Model inspection is optional and used for augmenting metadata only.

## Next Actions

- Define the migration metadata DSL and YAML schema for table info.
- Implement parsers to extract metadata from migrations safely (no eval).
- Implement merging rules (priority: YAML overrides parsed metadata, model augmentations supplement).
