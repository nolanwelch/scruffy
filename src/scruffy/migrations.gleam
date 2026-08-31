//// A type describing Scryfall's Card Migration object, used to track when
//// one Scryfall card ID replaces another.
////
//// See https://scryfall.com/docs/api/migrations for the upstream reference.

import gleam/option.{type Option}
import gleam/uri.{type Uri}
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

/// How a migration should be applied to references to the old card ID.
pub type MigrationStrategy {
  Merge
  Delete
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
