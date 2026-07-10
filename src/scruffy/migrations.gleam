import gleam/option.{type Option}
import gleam/uri.{type Uri}
import scruffy/common.{type Uuid}

pub type CardMigration {
  CardMigration(
    uri: Uri,
    id: Uuid,
    performed_at: Int,
    migration_strategy: MigrationStrategy,
    old_scryfall_id: Uuid,
    new_scryfall_id: Option(Uuid),
    note: Option(String),
    metadata: Option(MigrationMetadata),
  )
}

pub type MigrationStrategy {
  Merge
  Delete
}

pub type MigrationMetadata {
  MigrationMetadata(
    id: Option(Uuid),
    language: Option(String),
    name: Option(String),
    set_code: Option(String),
    oracle_id: Option(Uuid),
    collector_number: Option(String),
  )
}
