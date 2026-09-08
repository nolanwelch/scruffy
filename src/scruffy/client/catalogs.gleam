//// Requests and response decoders for Scryfall's Catalogs endpoints.
////
//// Every endpoint here returns the same shape, a `Catalog(String)`, so
//// there's a single `catalog_response` to decode all of them -- build the
//// request with whichever `get_*_request` matches the catalog you want,
//// send it with your own HTTP client, then decode its response with
//// `catalog_response`.
////
//// See https://scryfall.com/docs/api/catalogs for the upstream reference.

import gleam/http
import gleam/http/request.{type Request} as _
import gleam/http/response.{type Response}
import glon
import scruffy/catalog.{type Catalog}
import scruffy/client.{type ClientError}
import scruffy/client/request

fn catalog_request(name: String) -> Request(String) {
  request.new(http.Get, ["catalog", name])
}

/// Decode a response as a `Catalog(String)`. Pairs with every `get_*_request`
/// function below.
pub fn catalog_response(
  resp: Response(String),
) -> Result(Catalog(String), ClientError) {
  client.decode_response(resp, then: catalog.catalog_schema(of: glon.string()))
}

/// Build a request for a Catalog of all English card names in Scryfall's
/// database.
pub fn get_card_names_request() -> Request(String) {
  catalog_request("card-names")
}

/// Build a request for a Catalog of all canonical artist names in
/// Scryfall's database.
pub fn get_artist_names_request() -> Request(String) {
  catalog_request("artist-names")
}

/// Build a request for a Catalog of all words that could appear in a card
/// name.
pub fn get_word_bank_request() -> Request(String) {
  catalog_request("word-bank")
}

/// Build a request for a Catalog of all card supertypes in Scryfall's
/// database.
pub fn get_supertypes_request() -> Request(String) {
  catalog_request("supertypes")
}

/// Build a request for a Catalog of all card types in Scryfall's database.
pub fn get_card_types_request() -> Request(String) {
  catalog_request("card-types")
}

/// Build a request for a Catalog of all artifact types in Scryfall's
/// database.
pub fn get_artifact_types_request() -> Request(String) {
  catalog_request("artifact-types")
}

/// Build a request for a Catalog of all battle types in Scryfall's
/// database.
pub fn get_battle_types_request() -> Request(String) {
  catalog_request("battle-types")
}

/// Build a request for a Catalog of all creature types in Scryfall's
/// database.
pub fn get_creature_types_request() -> Request(String) {
  catalog_request("creature-types")
}

/// Build a request for a Catalog of all enchantment types in Scryfall's
/// database.
pub fn get_enchantment_types_request() -> Request(String) {
  catalog_request("enchantment-types")
}

/// Build a request for a Catalog of all land types in Scryfall's database.
pub fn get_land_types_request() -> Request(String) {
  catalog_request("land-types")
}

/// Build a request for a Catalog of all planeswalker types in Scryfall's
/// database.
pub fn get_planeswalker_types_request() -> Request(String) {
  catalog_request("planeswalker-types")
}

/// Build a request for a Catalog of all spell types in Scryfall's database.
pub fn get_spell_types_request() -> Request(String) {
  catalog_request("spell-types")
}

/// Build a request for a Catalog of all possible values for a creature
/// card's power.
pub fn get_powers_request() -> Request(String) {
  catalog_request("powers")
}

/// Build a request for a Catalog of all possible values for a creature
/// card's toughness.
pub fn get_toughnesses_request() -> Request(String) {
  catalog_request("toughnesses")
}

/// Build a request for a Catalog of all possible values for a planeswalker
/// card's loyalty.
pub fn get_loyalties_request() -> Request(String) {
  catalog_request("loyalties")
}

/// Build a request for a Catalog of all keyword abilities in Scryfall's
/// database.
pub fn get_keyword_abilities_request() -> Request(String) {
  catalog_request("keyword-abilities")
}

/// Build a request for a Catalog of all keyword actions in Scryfall's
/// database.
pub fn get_keyword_actions_request() -> Request(String) {
  catalog_request("keyword-actions")
}

/// Build a request for a Catalog of all ability words in Scryfall's
/// database.
pub fn get_ability_words_request() -> Request(String) {
  catalog_request("ability-words")
}

/// Build a request for a Catalog of all flavor words in Scryfall's
/// database.
pub fn get_flavor_words_request() -> Request(String) {
  catalog_request("flavor-words")
}

/// Build a request for a Catalog of all watermarks in Scryfall's database.
pub fn get_watermarks_request() -> Request(String) {
  catalog_request("watermarks")
}
