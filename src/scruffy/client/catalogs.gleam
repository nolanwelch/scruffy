//// Functions for calling Scryfall's Catalogs endpoints.
////
//// Each function builds its request with `scruffy/client/request` and
//// sends it with the `client.Requester` you provide, so what comes back
//// is already the decoded `Catalog` -- or a `client.ClientError`
//// describing what went wrong.
////
//// See https://scryfall.com/docs/api/catalogs for the upstream reference.

import gleam/http
import glon
import scruffy/catalog.{type Catalog}
import scruffy/client.{type ClientError, type Requester}
import scruffy/client/request

fn get_catalog(
  requester: Requester(e),
  name: String,
) -> Result(Catalog(String), ClientError(e)) {
  request.new(http.Get, ["catalog", name])
  |> client.send(
    using: requester,
    then: catalog.catalog_schema(of: glon.string()),
  )
}

/// Get a Catalog of all English card names in Scryfall's database.
pub fn get_card_names(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "card-names")
}

/// Get a Catalog of all canonical artist names in Scryfall's database.
pub fn get_artist_names(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "artist-names")
}

/// Get a Catalog of all words that could appear in a card name.
pub fn get_word_bank(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "word-bank")
}

/// Get a Catalog of all card supertypes in Scryfall's database.
pub fn get_supertypes(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "supertypes")
}

/// Get a Catalog of all card types in Scryfall's database.
pub fn get_card_types(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "card-types")
}

/// Get a Catalog of all artifact types in Scryfall's database.
pub fn get_artifact_types(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "artifact-types")
}

/// Get a Catalog of all battle types in Scryfall's database.
pub fn get_battle_types(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "battle-types")
}

/// Get a Catalog of all creature types in Scryfall's database.
pub fn get_creature_types(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "creature-types")
}

/// Get a Catalog of all enchantment types in Scryfall's database.
pub fn get_enchantment_types(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "enchantment-types")
}

/// Get a Catalog of all land types in Scryfall's database.
pub fn get_land_types(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "land-types")
}

/// Get a Catalog of all planeswalker types in Scryfall's database.
pub fn get_planeswalker_types(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "planeswalker-types")
}

/// Get a Catalog of all spell types in Scryfall's database.
pub fn get_spell_types(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "spell-types")
}

/// Get a Catalog of all possible values for a creature card's power.
pub fn get_powers(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "powers")
}

/// Get a Catalog of all possible values for a creature card's toughness.
pub fn get_toughnesses(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "toughnesses")
}

/// Get a Catalog of all possible values for a planeswalker card's loyalty.
pub fn get_loyalties(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "loyalties")
}

/// Get a Catalog of all keyword abilities in Scryfall's database.
pub fn get_keyword_abilities(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "keyword-abilities")
}

/// Get a Catalog of all keyword actions in Scryfall's database.
pub fn get_keyword_actions(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "keyword-actions")
}

/// Get a Catalog of all ability words in Scryfall's database.
pub fn get_ability_words(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "ability-words")
}

/// Get a Catalog of all flavor words in Scryfall's database.
pub fn get_flavor_words(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "flavor-words")
}

/// Get a Catalog of all watermarks in Scryfall's database.
pub fn get_watermarks(
  requester: Requester(e),
) -> Result(Catalog(String), ClientError(e)) {
  get_catalog(requester, "watermarks")
}
