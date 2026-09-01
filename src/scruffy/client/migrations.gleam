//// Functions for calling Scryfall's Card Migrations endpoints.
////
//// Each function builds its request with `scruffy/client/request` and
//// sends it with the `client.Requester` you provide, so what comes back
//// is already the decoded object -- or a `client.ClientError` describing
//// what went wrong.
////
//// See https://scryfall.com/docs/api/migrations for the upstream reference.

import gleam/http
import gleam/int
import gleam/option.{type Option}
import scruffy/client.{type ClientError, type Requester}
import scruffy/client/request
import scruffy/common.{type Uuid}
import scruffy/migrations.{type CardMigration}
import scruffy/scryfall_list.{type ScryfallList}

/// List Scryfall's card migrations, paginated and ordered with the most
/// recently performed migration first.
pub fn list_migrations(
  requester: Requester(e),
  page: Option(Int),
) -> Result(ScryfallList(CardMigration), ClientError(e)) {
  request.new(http.Get, ["migrations"])
  |> request.with_query([#("page", option.map(page, int.to_string))])
  |> client.send(
    using: requester,
    then: scryfall_list.scryfall_list_schema(
      of: migrations.card_migration_schema(),
    ),
  )
}

/// Get a single card migration by its Scryfall migration ID.
pub fn get_migration(
  requester: Requester(e),
  id: Uuid,
) -> Result(CardMigration, ClientError(e)) {
  request.new(http.Get, ["migrations", id])
  |> client.send(using: requester, then: migrations.card_migration_schema())
}
