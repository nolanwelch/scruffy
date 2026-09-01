//// Functions for calling Scryfall's Catalogs endpoints.
////
//// Each function builds its request with `scruffy/client/request` and
//// sends it with the `client.Requester` you provide, so what comes back
//// is already the decoded `Catalog` -- or a `client.ClientError`
//// describing what went wrong. Call `new` once with your `Requester` to
//// get a `Client` back with all of them already wired up, if you'd rather
//// not pass one at every call site.
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

/// Every function above, already wired up to a `Requester` -- see `new`.
pub type Client(e) {
  Client(
    get_card_names: fn() -> Result(Catalog(String), ClientError(e)),
    get_artist_names: fn() -> Result(Catalog(String), ClientError(e)),
    get_word_bank: fn() -> Result(Catalog(String), ClientError(e)),
    get_supertypes: fn() -> Result(Catalog(String), ClientError(e)),
    get_card_types: fn() -> Result(Catalog(String), ClientError(e)),
    get_artifact_types: fn() -> Result(Catalog(String), ClientError(e)),
    get_battle_types: fn() -> Result(Catalog(String), ClientError(e)),
    get_creature_types: fn() -> Result(Catalog(String), ClientError(e)),
    get_enchantment_types: fn() -> Result(Catalog(String), ClientError(e)),
    get_land_types: fn() -> Result(Catalog(String), ClientError(e)),
    get_planeswalker_types: fn() -> Result(Catalog(String), ClientError(e)),
    get_spell_types: fn() -> Result(Catalog(String), ClientError(e)),
    get_powers: fn() -> Result(Catalog(String), ClientError(e)),
    get_toughnesses: fn() -> Result(Catalog(String), ClientError(e)),
    get_loyalties: fn() -> Result(Catalog(String), ClientError(e)),
    get_keyword_abilities: fn() -> Result(Catalog(String), ClientError(e)),
    get_keyword_actions: fn() -> Result(Catalog(String), ClientError(e)),
    get_ability_words: fn() -> Result(Catalog(String), ClientError(e)),
    get_flavor_words: fn() -> Result(Catalog(String), ClientError(e)),
    get_watermarks: fn() -> Result(Catalog(String), ClientError(e)),
  )
}

/// Build a `Client` bound to the given `Requester`, so you don't have to
/// pass one to every call: `let catalogs = catalogs.new(httpc.send)` then
/// `catalogs.get_card_names()`.
pub fn new(requester: Requester(e)) -> Client(e) {
  Client(
    get_card_names: fn() { get_card_names(requester) },
    get_artist_names: fn() { get_artist_names(requester) },
    get_word_bank: fn() { get_word_bank(requester) },
    get_supertypes: fn() { get_supertypes(requester) },
    get_card_types: fn() { get_card_types(requester) },
    get_artifact_types: fn() { get_artifact_types(requester) },
    get_battle_types: fn() { get_battle_types(requester) },
    get_creature_types: fn() { get_creature_types(requester) },
    get_enchantment_types: fn() { get_enchantment_types(requester) },
    get_land_types: fn() { get_land_types(requester) },
    get_planeswalker_types: fn() { get_planeswalker_types(requester) },
    get_spell_types: fn() { get_spell_types(requester) },
    get_powers: fn() { get_powers(requester) },
    get_toughnesses: fn() { get_toughnesses(requester) },
    get_loyalties: fn() { get_loyalties(requester) },
    get_keyword_abilities: fn() { get_keyword_abilities(requester) },
    get_keyword_actions: fn() { get_keyword_actions(requester) },
    get_ability_words: fn() { get_ability_words(requester) },
    get_flavor_words: fn() { get_flavor_words(requester) },
    get_watermarks: fn() { get_watermarks(requester) },
  )
}
