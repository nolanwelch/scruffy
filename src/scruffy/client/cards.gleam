//// Stub methods for calling Scryfall's Cards endpoints.
////
//// See https://scryfall.com/docs/api/cards for the upstream reference.

import gleam/option.{type Option}
import scruffy/card.{type Card}
import scruffy/catalog.{type Catalog}
import scruffy/common.{type Uuid}
import scruffy/language.{type Language}
import scruffy/scryfall_list.{type ScryfallList}

/// How cards with multiple versions should be collapsed by `search_cards`.
pub type UniqueMode {
  UniqueCards
  UniqueArt
  UniquePrints
}

/// The field `search_cards` results are sorted by.
pub type SortOrder {
  ByName
  BySet
  ByReleased
  ByRarity
  ByColor
  ByUsd
  ByTix
  ByEur
  ByCmc
  ByPower
  ByToughness
  ByEdhrec
  ByPenny
  ByArtist
  ByReview
}

/// The direction `search_cards` results are sorted in.
pub type SortDirection {
  Auto
  Ascending
  Descending
}

/// Optional parameters accepted by `search_cards`.
pub type SearchOptions {
  SearchOptions(
    unique: Option(UniqueMode),
    order: Option(SortOrder),
    dir: Option(SortDirection),
    include_extras: Option(Bool),
    include_multilingual: Option(Bool),
    include_variations: Option(Bool),
    page: Option(Int),
  )
}

/// Get a lightweight manifest of every card Scryfall has on file.
pub fn get_cards_manifest() -> ScryfallList(Card) {
  todo
}

/// Search for cards using Scryfall's full-text search syntax.
pub fn search_cards(q: String, options: SearchOptions) -> ScryfallList(Card) {
  todo
}

/// A way of identifying a card by name, either exactly or through
/// Scryfall's fuzzy-matching algorithm.
pub type NameQuery {
  Exact(String)
  Fuzzy(String)
}

/// Get a single card by name, optionally scoped to a particular set.
pub fn get_card_by_name(query: NameQuery, set: Option(String)) -> Option(Card) {
  todo
}

/// Get a Catalog of Magic-related word fragments that can be used as the
/// start of a full card name, for use in a typeahead search bar.
pub fn autocomplete_card_name(
  q: String,
  include_extras: Option(Bool),
) -> Catalog(String) {
  todo
}

/// Get a random card, optionally scoped to cards matching a search query.
pub fn get_random_card(q: Option(String)) -> Option(Card) {
  todo
}

/// A way of identifying a single card within a `get_card_collection`
/// request.
pub type CardIdentifier {
  IdentifierById(Uuid)
  IdentifierByMtgoId(Int)
  IdentifierByMultiverseId(Int)
  IdentifierByOracleId(Uuid)
  IdentifierByIllustrationId(Uuid)
  IdentifierByName(String)
  IdentifierByNameAndSet(name: String, set: String)
  IdentifierByCollectorNumber(set: String, collector_number: String)
}

/// The response to a `get_card_collection` request: the cards that were
/// found, plus any identifiers that couldn't be matched to a card.
pub type CardCollection {
  CardCollection(data: List(Card), not_found: List(CardIdentifier))
}

/// Get a list of up to 75 cards at once, identified in bulk by ID, name, or
/// set/collector number.
pub fn get_card_collection(
  identifiers: List(CardIdentifier),
) -> CardCollection {
  todo
}

/// Get a single card by its set code, collector number, and (optionally) a
/// specific language.
pub fn get_card_by_set_and_number(
  set: String,
  collector_number: String,
  lang: Option(Language),
) -> Option(Card) {
  todo
}

/// Get a single card by its multiverse ID, as assigned by Wizards'
/// Gatherer.
pub fn get_card_by_multiverse_id(id: Int) -> Option(Card) {
  todo
}

/// Get a single card by its Magic Online ID.
pub fn get_card_by_mtgo_id(id: Int) -> Option(Card) {
  todo
}

/// Get a single card by its MTG Arena ID.
pub fn get_card_by_arena_id(id: Int) -> Option(Card) {
  todo
}

/// Get a single card by its TCGplayer product ID.
pub fn get_card_by_tcgplayer_id(id: Int) -> Option(Card) {
  todo
}

/// Get a single card by its Cardmarket product ID.
pub fn get_card_by_cardmarket_id(id: Int) -> Option(Card) {
  todo
}

/// Get a single card by its Scryfall ID.
pub fn get_card_by_id(id: Uuid) -> Option(Card) {
  todo
}
