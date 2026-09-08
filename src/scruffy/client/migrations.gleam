//// Requests and response decoders for Scryfall's Card Migrations endpoints.
////
//// Build a request with one of the `*_request` functions below, send it
//// with your own HTTP client, then decode its response with the matching
//// `*_response` function.
////
//// See https://scryfall.com/docs/api/migrations for the upstream reference.

import gleam/http
import gleam/http/request.{type Request} as http_request
import gleam/http/response.{type Response}
import gleam/int
import gleam/option.{type Option}
import scruffy/client.{type ClientError}
import scruffy/client/request
import scruffy/common.{type Uuid}
import scruffy/migrations.{type CardMigration}
import scruffy/scryfall_list.{type ScryfallList}

/// Build a request to list Scryfall's card migrations, paginated and
/// ordered with the most recently performed migration first. Pair the
/// response with `migration_list_response`.
pub fn list_migrations_request(page: Option(Int)) -> Request(String) {
  request.new(http.Get, ["migrations"])
  |> request.with_query([#("page", option.map(page, int.to_string))])
}

/// Decode a response as a `ScryfallList(CardMigration)`. Pairs with
/// `list_migrations_request`.
pub fn migration_list_response(
  resp: Response(String),
) -> Result(ScryfallList(CardMigration), ClientError) {
  client.decode_response(
    resp,
    then: scryfall_list.scryfall_list_schema(
      of: migrations.card_migration_schema(),
    ),
  )
}

/// Build a request for a single card migration by its Scryfall migration
/// ID. Pair the response with `migration_response`.
pub fn get_migration_request(id: Uuid) -> Request(String) {
  request.new(http.Get, ["migrations", id])
}

/// Decode a response as a single `CardMigration`. Pairs with
/// `get_migration_request`.
pub fn migration_response(
  resp: Response(String),
) -> Result(CardMigration, ClientError) {
  client.decode_response(resp, then: migrations.card_migration_schema())
}
