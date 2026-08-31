//// Stub methods for calling Scryfall's Card Migrations endpoints.
////
//// See https://scryfall.com/docs/api/migrations for the upstream reference.

import gleam/option.{type Option}
import scruffy/common.{type Uuid}
import scruffy/migrations.{type CardMigration}
import scruffy/scryfall_list.{type ScryfallList}

/// List Scryfall's card migrations, paginated and ordered with the most
/// recently performed migration first.
pub fn list_migrations(page: Option(Int)) -> ScryfallList(CardMigration) {
  todo
}

/// Get a single card migration by its Scryfall migration ID.
pub fn get_migration(id: Uuid) -> Option(CardMigration) {
  todo
}
