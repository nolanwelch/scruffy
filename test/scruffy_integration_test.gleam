//// Integration tests that exercise `scruffy/client/*` end to end against
//// the real, live Scryfall API, sending requests with `gleam_httpc`.
////
//// These are deliberately separate from `scruffy_test.gleam`'s pure decode
//// tests: they need network access to `api.scryfall.com`, so a failure
//// here can mean "no network" or "Scryfall is down" just as easily as "the
//// client is broken" -- check connectivity first. `gleam_httpc` is
//// Erlang-only, so every definition below is `@target(erlang)`-gated:
//// `gleam test --target javascript` simply skips this whole file and runs
//// `scruffy_test.gleam`'s decode tests instead.

@target(erlang)
import gleam/httpc

@target(erlang)
import gleam/option

@target(erlang)
import scruffy/bulk_data as bulk_data_type

@target(erlang)
import scruffy/client

@target(erlang)
import scruffy/client/bulk_data

@target(erlang)
import scruffy/client/cards

@target(erlang)
import scruffy/client/catalogs

@target(erlang)
import scruffy/client/migrations

// Black Lotus (Vintage Masters) -- a real card whose Scryfall ID is stable.
@target(erlang)
const black_lotus_id = "bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd"

// A well-formed UUID that doesn't correspond to any real card.
@target(erlang)
const nonexistent_id = "11111111-1111-4111-8111-111111111111"

@target(erlang)
pub fn get_card_by_id_test() {
  let assert Ok(resp) = cards.get_card_by_id_request(black_lotus_id) |> httpc.send
  let assert Ok(c) = cards.card_response(resp)
  assert c.name == "Black Lotus"
  assert c.id == black_lotus_id
}

@target(erlang)
pub fn get_card_by_id_not_found_test() {
  let assert Ok(resp) = cards.get_card_by_id_request(nonexistent_id) |> httpc.send
  let assert Error(client.ApiError(err)) = cards.card_response(resp)
  assert err.status == 404
  assert err.code == "not_found"
}

@target(erlang)
pub fn get_card_by_name_test() {
  let assert Ok(resp) =
    cards.get_card_by_name_request(cards.Exact("Black Lotus"), option.None)
    |> httpc.send
  let assert Ok(c) = cards.card_response(resp)
  assert c.name == "Black Lotus"
}

@target(erlang)
pub fn autocomplete_card_name_test() {
  // /cards/autocomplete has no `uri`, unlike the /catalog/* endpoints.
  let assert Ok(resp) =
    cards.autocomplete_card_name_request("Blac", option.None) |> httpc.send
  let assert Ok(cat) = cards.autocomplete_card_name_response(resp)
  assert cat.uri == option.None
  assert cat.total_values > 0
}

@target(erlang)
pub fn search_cards_test() {
  let assert Ok(resp) =
    cards.search_cards_request(
      "lightning bolt",
      cards.SearchOptions(
        unique: option.None,
        order: option.None,
        dir: option.None,
        include_extras: option.None,
        include_multilingual: option.None,
        include_variations: option.None,
        page: option.None,
      ),
    )
    |> httpc.send
  let assert Ok(list) = cards.card_list_response(resp)
  assert list.data != []
}

@target(erlang)
pub fn get_card_collection_test() {
  let assert Ok(resp) =
    cards.get_card_collection_request([
      cards.IdentifierByName("Black Lotus"),
      cards.IdentifierById(nonexistent_id),
    ])
    |> httpc.send
  let assert Ok(collection) = cards.card_collection_response(resp)
  assert list_length(collection.data) == 1
  assert list_length(collection.not_found) == 1
}

@target(erlang)
pub fn get_card_names_test() {
  // Unlike /cards/autocomplete, a true /catalog/* endpoint has a `uri`.
  let assert Ok(resp) = catalogs.get_card_names_request() |> httpc.send
  let assert Ok(cat) = catalogs.catalog_response(resp)
  assert cat.uri != option.None
  assert cat.total_values > 0
}

@target(erlang)
pub fn list_bulk_data_test() {
  let assert Ok(resp) = bulk_data.list_bulk_data_request() |> httpc.send
  let assert Ok(list) = bulk_data.bulk_data_list_response(resp)
  assert list.data != []
}

@target(erlang)
pub fn get_bulk_data_by_type_test() {
  let assert Ok(resp) =
    bulk_data.get_bulk_data_by_type_request(bulk_data_type.OracleCards)
    |> httpc.send
  let assert Ok(data) = bulk_data.bulk_data_response(resp)
  assert data.bulk_data_type == bulk_data_type.OracleCards
}

@target(erlang)
pub fn list_migrations_test() {
  let assert Ok(resp) =
    migrations.list_migrations_request(option.Some(1)) |> httpc.send
  let assert Ok(list) = migrations.migration_list_response(resp)
  assert list.data != []
}

@target(erlang)
fn list_length(l: List(a)) -> Int {
  case l {
    [] -> 0
    [_, ..rest] -> 1 + list_length(rest)
  }
}
