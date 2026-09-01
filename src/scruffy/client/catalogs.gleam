//// Functions for calling Scryfall's Catalogs endpoints.
////
//// Each function builds its request with `scruffy/client/request` and
//// sends it with `scruffy/client`, so what comes back is already the
//// decoded `Catalog` -- or a `client.ClientError` describing what went
//// wrong.
////
//// See https://scryfall.com/docs/api/catalogs for the upstream reference.

import gleam/http
import glon
import scruffy/catalog.{type Catalog}
import scruffy/client
import scruffy/client/request

fn get_catalog(name: String) -> Result(Catalog(String), client.ClientError) {
  request.new(http.Get, ["catalog", name])
  |> client.send(catalog.catalog_schema(of: glon.string()))
}

/// Get a Catalog of all English card names in Scryfall's database.
pub fn get_card_names() -> Result(Catalog(String), client.ClientError) {
  get_catalog("card-names")
}

/// Get a Catalog of all canonical artist names in Scryfall's database.
pub fn get_artist_names() -> Result(Catalog(String), client.ClientError) {
  get_catalog("artist-names")
}

/// Get a Catalog of all words that could appear in a card name.
pub fn get_word_bank() -> Result(Catalog(String), client.ClientError) {
  get_catalog("word-bank")
}

/// Get a Catalog of all card supertypes in Scryfall's database.
pub fn get_supertypes() -> Result(Catalog(String), client.ClientError) {
  get_catalog("supertypes")
}

/// Get a Catalog of all card types in Scryfall's database.
pub fn get_card_types() -> Result(Catalog(String), client.ClientError) {
  get_catalog("card-types")
}

/// Get a Catalog of all artifact types in Scryfall's database.
pub fn get_artifact_types() -> Result(Catalog(String), client.ClientError) {
  get_catalog("artifact-types")
}

/// Get a Catalog of all battle types in Scryfall's database.
pub fn get_battle_types() -> Result(Catalog(String), client.ClientError) {
  get_catalog("battle-types")
}

/// Get a Catalog of all creature types in Scryfall's database.
pub fn get_creature_types() -> Result(Catalog(String), client.ClientError) {
  get_catalog("creature-types")
}

/// Get a Catalog of all enchantment types in Scryfall's database.
pub fn get_enchantment_types() -> Result(Catalog(String), client.ClientError) {
  get_catalog("enchantment-types")
}

/// Get a Catalog of all land types in Scryfall's database.
pub fn get_land_types() -> Result(Catalog(String), client.ClientError) {
  get_catalog("land-types")
}

/// Get a Catalog of all planeswalker types in Scryfall's database.
pub fn get_planeswalker_types() -> Result(Catalog(String), client.ClientError) {
  get_catalog("planeswalker-types")
}

/// Get a Catalog of all spell types in Scryfall's database.
pub fn get_spell_types() -> Result(Catalog(String), client.ClientError) {
  get_catalog("spell-types")
}

/// Get a Catalog of all possible values for a creature card's power.
pub fn get_powers() -> Result(Catalog(String), client.ClientError) {
  get_catalog("powers")
}

/// Get a Catalog of all possible values for a creature card's toughness.
pub fn get_toughnesses() -> Result(Catalog(String), client.ClientError) {
  get_catalog("toughnesses")
}

/// Get a Catalog of all possible values for a planeswalker card's loyalty.
pub fn get_loyalties() -> Result(Catalog(String), client.ClientError) {
  get_catalog("loyalties")
}

/// Get a Catalog of all keyword abilities in Scryfall's database.
pub fn get_keyword_abilities() -> Result(Catalog(String), client.ClientError) {
  get_catalog("keyword-abilities")
}

/// Get a Catalog of all keyword actions in Scryfall's database.
pub fn get_keyword_actions() -> Result(Catalog(String), client.ClientError) {
  get_catalog("keyword-actions")
}

/// Get a Catalog of all ability words in Scryfall's database.
pub fn get_ability_words() -> Result(Catalog(String), client.ClientError) {
  get_catalog("ability-words")
}

/// Get a Catalog of all flavor words in Scryfall's database.
pub fn get_flavor_words() -> Result(Catalog(String), client.ClientError) {
  get_catalog("flavor-words")
}

/// Get a Catalog of all watermarks in Scryfall's database.
pub fn get_watermarks() -> Result(Catalog(String), client.ClientError) {
  get_catalog("watermarks")
}
