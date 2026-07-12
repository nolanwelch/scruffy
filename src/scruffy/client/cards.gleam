import gleam/option.{type Option}
import scruffy/card.{type Card}
import scruffy/catalog.{type Catalog}
import scruffy/language.{type Language}
import scruffy/list.{type ScryfallList}

pub fn get_card_manifest(
  lang: Option(Language),
  order: Option(CardManifestOrder),
) -> ScryfallList(Card) {
  todo
}

pub type CardManifestOrder {
  Released
  ImageUpdated
}

pub fn search_card(
  q: String,
  unique: Option(UniqueSearchStrategy),
  order: Option(SearchOrderingStrategy),
  dir: Option(SearchOrderingDirection),
  include_extras: Option(Bool),
  include_multilingual: Option(Bool),
  include_variations: Option(Bool),
  page: Option(Int),
  format: Option(SearchCardDataFormat),
  pretty: Option(Bool),
) -> ScryfallList(Card) {
  todo
}

pub type UniqueSearchStrategy {
  Cards
  Art
  Prints
}

pub type SearchOrderingStrategy {
  Name
  Set
  FirstReleased
  Rarity
  Color
  Usd
  Tix
  Eur
  Cmc
  Power
  Toughness
  Edhrec
  Penny
  Artist
  Review
}

pub type SearchOrderingDirection {
  Auto
  Ascending
  Descending
}

pub type SearchCardDataFormat {
  Json
  Csv
}

pub fn search_card_by_name(
  exact: String,
  fuzzy: String,
  set_code: Option(String),
  format: SearchCardByNameDataFormat,
  get_back: Option(Bool),
  pretty: Option(Bool),
) -> Option(Card) {
  todo
}

pub type SearchCardByNameDataFormat {
  // Definitely a smarter way to consolidate these types
  JsonFormat
  Text
  Image
}

pub fn autocomplete_card_name(
  q: String,
  pretty: Option(Bool),
  include_extras: Option(Bool),
) -> Catalog(String) {
  todo
}

pub fn get_random_card(
  q: Option(String),
  format: Option(GetRandomCardDataFormat),
  get_back: Option(Bool),
  version: Option(GetRandomCardImageVersion),
  pretty: Option(Bool),
) -> Card {
  todo
}

pub type GetRandomCardDataFormat {
  RandomJson
  RandomText
  RandomImage
}

pub type GetRandomCardImageVersion {
  Small
  Normal
  Large
  Png
  ArtCrop
  BorderCrop
}
