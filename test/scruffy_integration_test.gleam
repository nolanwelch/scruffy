//// Integration tests that exercise `scruffy/client/*` end to end against
//// the real, live Scryfall API.
////
//// These are deliberately separate from `scruffy_test.gleam`'s pure decode
//// tests: they need network access to `api.scryfall.com`, so a failure
//// here can mean "no network" or "Scryfall is down" just as easily as "the
//// client is broken" -- check connectivity first.

import gleam/option
import scruffy/bulk_data as bulk_data_type
import scruffy/client
import scruffy/client/bulk_data
import scruffy/client/cards
import scruffy/client/catalogs
import scruffy/client/migrations

// Black Lotus (Vintage Masters) -- a real card whose Scryfall ID is stable.
const black_lotus_id = "bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd"

// A well-formed UUID that doesn't correspond to any real card.
const nonexistent_id = "11111111-1111-4111-8111-111111111111"

pub fn get_card_by_id_test() {
  let assert Ok(c) = cards.get_card_by_id(black_lotus_id)
  assert c.name == "Black Lotus"
  assert c.id == black_lotus_id
}

pub fn get_card_by_id_not_found_test() {
  let assert Error(client.ApiError(err)) = cards.get_card_by_id(nonexistent_id)
  assert err.status == 404
  assert err.code == "not_found"
}

pub fn get_card_by_name_test() {
  let assert Ok(c) =
    cards.get_card_by_name(cards.Exact("Black Lotus"), option.None)
  assert c.name == "Black Lotus"
}

pub fn autocomplete_card_name_test() {
  // /cards/autocomplete has no `uri`, unlike the /catalog/* endpoints.
  let assert Ok(cat) = cards.autocomplete_card_name("Blac", option.None)
  assert cat.uri == option.None
  assert cat.total_values > 0
}

pub fn search_cards_test() {
  let assert Ok(list) =
    cards.search_cards(
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
  assert list.data != []
}

pub fn get_card_collection_test() {
  let assert Ok(collection) =
    cards.get_card_collection([
      cards.IdentifierByName("Black Lotus"),
      cards.IdentifierById(nonexistent_id),
    ])
  assert list_length(collection.data) == 1
  assert list_length(collection.not_found) == 1
}

pub fn get_card_names_test() {
  // Unlike /cards/autocomplete, a true /catalog/* endpoint has a `uri`.
  let assert Ok(cat) = catalogs.get_card_names()
  assert cat.uri != option.None
  assert cat.total_values > 0
}

pub fn list_bulk_data_test() {
  let assert Ok(list) = bulk_data.list_bulk_data()
  assert list.data != []
}

pub fn get_bulk_data_by_type_test() {
  let assert Ok(data) =
    bulk_data.get_bulk_data_by_type(bulk_data_type.OracleCards)
  assert data.bulk_data_type == bulk_data_type.OracleCards
}

pub fn list_migrations_test() {
  let assert Ok(list) = migrations.list_migrations(option.Some(1))
  assert list.data != []
}

fn list_length(l: List(a)) -> Int {
  case l {
    [] -> 0
    [_, ..rest] -> 1 + list_length(rest)
  }
}
