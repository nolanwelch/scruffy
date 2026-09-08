//// Requests and response decoders for Scryfall's Cards endpoints.
////
//// Each endpoint is a pair of plain functions: a `*_request` that builds
//// the `Request(String)` to send, and a `*_response` that decodes the
//// `Response(String)` you got back into a `Card` (or the handful of
//// endpoints that return something else) -- or a `client.ClientError`
//// describing what went wrong. Several endpoints below share a
//// `*_response` function since they decode the same shape; the doc comment
//// on each `*_request` says which one to pair it with.
////
//// See https://scryfall.com/docs/api/cards for the upstream reference.

import gleam/http
import gleam/http/request.{type Request} as http_request
import gleam/http/response.{type Response}
import gleam/int
import gleam/json.{type Json}
import gleam/option.{type Option}
import glon
import scruffy/card.{type Card}
import scruffy/catalog.{type Catalog}
import scruffy/client.{type ClientError}
import scruffy/client/request
import scruffy/common.{type Uuid}
import scruffy/language.{type Language}
import scruffy/scryfall_list.{type ScryfallList}

/// How cards with multiple versions should be collapsed by `search_cards`.
pub type UniqueMode {
  UniqueCards
  UniqueArt
  UniquePrints
}

fn unique_mode_to_string(mode: UniqueMode) -> String {
  case mode {
    UniqueCards -> "cards"
    UniqueArt -> "art"
    UniquePrints -> "prints"
  }
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

fn sort_order_to_string(order: SortOrder) -> String {
  case order {
    ByName -> "name"
    BySet -> "set"
    ByReleased -> "released"
    ByRarity -> "rarity"
    ByColor -> "color"
    ByUsd -> "usd"
    ByTix -> "tix"
    ByEur -> "eur"
    ByCmc -> "cmc"
    ByPower -> "power"
    ByToughness -> "toughness"
    ByEdhrec -> "edhrec"
    ByPenny -> "penny"
    ByArtist -> "artist"
    ByReview -> "review"
  }
}

/// The direction `search_cards` results are sorted in.
pub type SortDirection {
  Auto
  Ascending
  Descending
}

fn sort_direction_to_string(dir: SortDirection) -> String {
  case dir {
    Auto -> "auto"
    Ascending -> "asc"
    Descending -> "desc"
  }
}

fn bool_to_string(b: Bool) -> String {
  case b {
    True -> "true"
    False -> "false"
  }
}

/// Optional parameters accepted by `search_cards_request`.
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

/// Decode a response as a `ScryfallList(Card)`. Pairs with
/// `get_cards_manifest_request` and `search_cards_request`.
pub fn card_list_response(
  resp: Response(String),
) -> Result(ScryfallList(Card), ClientError) {
  client.decode_response(
    resp,
    then: scryfall_list.scryfall_list_schema(of: card.card_schema()),
  )
}

/// Decode a response as a single `Card`. Pairs with every `get_card_by_*`
/// and `get_card_by_name_request`/`get_random_card_request` below.
pub fn card_response(resp: Response(String)) -> Result(Card, ClientError) {
  client.decode_response(resp, then: card.card_schema())
}

/// Build a request for a lightweight manifest of every card Scryfall has on
/// file. Pair the response with `card_list_response`.
pub fn get_cards_manifest_request() -> Request(String) {
  request.new(http.Get, ["cards"])
}

/// Build a request to search for cards using Scryfall's full-text search
/// syntax. Pair the response with `card_list_response`.
pub fn search_cards_request(
  q: String,
  options: SearchOptions,
) -> Request(String) {
  request.new(http.Get, ["cards", "search"])
  |> request.with_query([
    #("q", option.Some(q)),
    #("unique", option.map(options.unique, unique_mode_to_string)),
    #("order", option.map(options.order, sort_order_to_string)),
    #("dir", option.map(options.dir, sort_direction_to_string)),
    #("include_extras", option.map(options.include_extras, bool_to_string)),
    #(
      "include_multilingual",
      option.map(options.include_multilingual, bool_to_string),
    ),
    #(
      "include_variations",
      option.map(options.include_variations, bool_to_string),
    ),
    #("page", option.map(options.page, int.to_string)),
  ])
}

/// A way of identifying a card by name, either exactly or through
/// Scryfall's fuzzy-matching algorithm.
pub type NameQuery {
  Exact(String)
  Fuzzy(String)
}

/// Build a request for a single card by name, optionally scoped to a
/// particular set. Pair the response with `card_response`.
pub fn get_card_by_name_request(
  query: NameQuery,
  set: Option(String),
) -> Request(String) {
  let name_param = case query {
    Exact(name) -> #("exact", option.Some(name))
    Fuzzy(name) -> #("fuzzy", option.Some(name))
  }

  request.new(http.Get, ["cards", "named"])
  |> request.with_query([name_param, #("set", set)])
}

/// Build a request for a Catalog of Magic-related word fragments that can
/// be used as the start of a full card name, for use in a typeahead search
/// bar.
pub fn autocomplete_card_name_request(
  q: String,
  include_extras: Option(Bool),
) -> Request(String) {
  request.new(http.Get, ["cards", "autocomplete"])
  |> request.with_query([
    #("q", option.Some(q)),
    #("include_extras", option.map(include_extras, bool_to_string)),
  ])
}

/// Decode a response as a `Catalog(String)`. Pairs with
/// `autocomplete_card_name_request`.
pub fn autocomplete_card_name_response(
  resp: Response(String),
) -> Result(Catalog(String), ClientError) {
  client.decode_response(resp, then: catalog.catalog_schema(of: glon.string()))
}

/// Build a request for a random card, optionally scoped to cards matching a
/// search query. Pair the response with `card_response`.
pub fn get_random_card_request(q: Option(String)) -> Request(String) {
  request.new(http.Get, ["cards", "random"])
  |> request.with_query([#("q", q)])
}

/// A way of identifying a single card within a `get_card_collection_request`
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

/// Encodes a `CardIdentifier` the way `POST /cards/collection` expects it
/// in its request body.
fn card_identifier_to_json(identifier: CardIdentifier) -> Json {
  case identifier {
    IdentifierById(id) -> json.object([#("id", json.string(id))])
    IdentifierByMtgoId(id) -> json.object([#("mtgo_id", json.int(id))])
    IdentifierByMultiverseId(id) ->
      json.object([#("multiverse_id", json.int(id))])
    IdentifierByOracleId(id) -> json.object([#("oracle_id", json.string(id))])
    IdentifierByIllustrationId(id) ->
      json.object([#("illustration_id", json.string(id))])
    IdentifierByName(name) -> json.object([#("name", json.string(name))])
    IdentifierByNameAndSet(name:, set:) ->
      json.object([#("name", json.string(name)), #("set", json.string(set))])
    IdentifierByCollectorNumber(set:, collector_number:) ->
      json.object([
        #("set", json.string(set)),
        #("collector_number", json.string(collector_number)),
      ])
  }
}

/// Decodes a `CardIdentifier` back out of the echoed form Scryfall returns
/// it in under `not_found`, trying each of the identifier shapes in turn.
fn card_identifier_schema() -> glon.JsonSchema(CardIdentifier) {
  glon.one_of([
    {
      use id <- glon.field("id", common.uuid_schema())
      glon.success(IdentifierById(id))
    },
    {
      use id <- glon.field("mtgo_id", glon.integer())
      glon.success(IdentifierByMtgoId(id))
    },
    {
      use id <- glon.field("multiverse_id", glon.integer())
      glon.success(IdentifierByMultiverseId(id))
    },
    {
      use id <- glon.field("oracle_id", common.uuid_schema())
      glon.success(IdentifierByOracleId(id))
    },
    {
      use id <- glon.field("illustration_id", common.uuid_schema())
      glon.success(IdentifierByIllustrationId(id))
    },
    {
      use name <- glon.field("name", glon.string())
      use set <- glon.field("set", glon.string())
      glon.success(IdentifierByNameAndSet(name:, set:))
    },
    {
      use name <- glon.field("name", glon.string())
      glon.success(IdentifierByName(name))
    },
    {
      use set <- glon.field("set", glon.string())
      use collector_number <- glon.field("collector_number", glon.string())
      glon.success(IdentifierByCollectorNumber(set:, collector_number:))
    },
  ])
}

/// The response to a `get_card_collection_request` request: the cards that
/// were found, plus any identifiers that couldn't be matched to a card.
pub type CardCollection {
  CardCollection(data: List(Card), not_found: List(CardIdentifier))
}

fn card_collection_schema() -> glon.JsonSchema(CardCollection) {
  use data <- glon.field("data", glon.array(of: card.card_schema()))
  use not_found <- glon.field(
    "not_found",
    glon.array(of: card_identifier_schema()),
  )
  glon.success(CardCollection(data:, not_found:))
}

/// Build a request for up to 75 cards at once, identified in bulk by ID,
/// name, or set/collector number. Pair the response with
/// `card_collection_response`.
pub fn get_card_collection_request(
  identifiers: List(CardIdentifier),
) -> Request(String) {
  let body =
    json.object([
      #("identifiers", json.array(identifiers, of: card_identifier_to_json)),
    ])

  request.new(http.Post, ["cards", "collection"])
  |> request.with_json_body(body)
}

/// Decode a response as a `CardCollection`. Pairs with
/// `get_card_collection_request`.
pub fn card_collection_response(
  resp: Response(String),
) -> Result(CardCollection, ClientError) {
  client.decode_response(resp, then: card_collection_schema())
}

fn language_to_code(l: Language) -> String {
  case l {
    language.English -> "en"
    language.Spanish -> "es"
    language.French -> "fr"
    language.German -> "de"
    language.Italian -> "it"
    language.Portuguese -> "pt"
    language.Japanese -> "ja"
    language.Korean -> "ko"
    language.Russian -> "ru"
    language.SimplifiedChinese -> "zhs"
    language.TraditionalChinese -> "zht"
    language.Hebrew -> "he"
    language.Latin -> "la"
    language.AncientGreek -> "grc"
    language.Arabic -> "ar"
    language.Sanskrit -> "sa"
    language.Phyrexian -> "ph"
    language.Quenya -> "qya"
    language.Dwarvish -> "dw"
  }
}

/// Build a request for a single card by its set code, collector number, and
/// (optionally) a specific language. Pair the response with
/// `card_response`.
pub fn get_card_by_set_and_number_request(
  set: String,
  collector_number: String,
  lang: Option(Language),
) -> Request(String) {
  let path = case lang {
    option.Some(l) -> ["cards", set, collector_number, language_to_code(l)]
    option.None -> ["cards", set, collector_number]
  }

  request.new(http.Get, path)
}

/// Build a request for a single card by its multiverse ID, as assigned by
/// Wizards' Gatherer. Pair the response with `card_response`.
pub fn get_card_by_multiverse_id_request(id: Int) -> Request(String) {
  request.new(http.Get, ["cards", "multiverse", int.to_string(id)])
}

/// Build a request for a single card by its Magic Online ID. Pair the
/// response with `card_response`.
pub fn get_card_by_mtgo_id_request(id: Int) -> Request(String) {
  request.new(http.Get, ["cards", "mtgo", int.to_string(id)])
}

/// Build a request for a single card by its MTG Arena ID. Pair the response
/// with `card_response`.
pub fn get_card_by_arena_id_request(id: Int) -> Request(String) {
  request.new(http.Get, ["cards", "arena", int.to_string(id)])
}

/// Build a request for a single card by its TCGplayer product ID. Pair the
/// response with `card_response`.
pub fn get_card_by_tcgplayer_id_request(id: Int) -> Request(String) {
  request.new(http.Get, ["cards", "tcgplayer", int.to_string(id)])
}

/// Build a request for a single card by its Cardmarket product ID. Pair the
/// response with `card_response`.
pub fn get_card_by_cardmarket_id_request(id: Int) -> Request(String) {
  request.new(http.Get, ["cards", "cardmarket", int.to_string(id)])
}

/// Build a request for a single card by its Scryfall ID. Pair the response
/// with `card_response`.
pub fn get_card_by_id_request(id: Uuid) -> Request(String) {
  request.new(http.Get, ["cards", id])
}
