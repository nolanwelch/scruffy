//// A type describing Scryfall's Card Migration object, used to track when
//// one Scryfall card ID replaces another.
////
//// See https://scryfall.com/docs/api/migrations for the upstream reference.

import gleam/option.{type Option}
import gleam/uri.{type Uri}
import glon
import scruffy/common.{type Uuid}

/// A record of a Scryfall card ID being merged into or deleted in favor of
/// another.
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

pub fn card_migration_schema() -> glon.JsonSchema(CardMigration) {
  use uri <- glon.field("uri", common.uri_schema())
  use id <- glon.field("id", common.uuid_schema())
  use performed_at <- glon.field("performed_at", common.date_schema())
  use migration_strategy <- glon.field(
    "migration_strategy",
    migration_strategy_schema(),
  )
  use old_scryfall_id <- glon.field("old_scryfall_id", common.uuid_schema())
  use new_scryfall_id <- glon.optional("new_scryfall_id", common.uuid_schema())
  use note <- glon.optional("note", glon.string())
  use metadata <- glon.optional("metadata", migration_metadata_schema())
  glon.success(CardMigration(
    uri:,
    id:,
    performed_at:,
    migration_strategy:,
    old_scryfall_id:,
    new_scryfall_id:,
    note:,
    metadata:,
  ))
}

/// How a migration should be applied to references to the old card ID.
pub type MigrationStrategy {
  Merge
  Delete
}

pub fn migration_strategy_schema() -> glon.JsonSchema(MigrationStrategy) {
  glon.enum_map([#("merge", Merge), #("delete", Delete)])
}

/// Identifying details of the card a migration applies to.
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

pub fn migration_metadata_schema() -> glon.JsonSchema(MigrationMetadata) {
  use id <- glon.optional("id", common.uuid_schema())
  // The API's JSON key is `lang`, not `language`.
  use language <- glon.optional("lang", glon.string())
  use name <- glon.optional("name", glon.string())
  use set_code <- glon.optional("set_code", glon.string())
  use oracle_id <- glon.optional("oracle_id", common.uuid_schema())
  use collector_number <- glon.optional("collector_number", glon.string())
  glon.success(MigrationMetadata(
    id:,
    language:,
    name:,
    set_code:,
    oracle_id:,
    collector_number:,
  ))
}
