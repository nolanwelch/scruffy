//// A type describing Scryfall's Card Symbol object, used to render mana
//// costs, the tap symbol, and other symbols found in oracle text.
////
//// See https://scryfall.com/docs/api/card-symbols for the upstream reference.

import gleam/option.{type Option}
import gleam/uri.{type Uri}
import glon
import scruffy/color.{type Color}
import scruffy/common

/// A symbol that can appear in a card's mana cost or oracle text, such as
/// `{T}` or `{2/W}`.
pub type CardSymbol {
  CardSymbol(
    symbol: String,
    loose_variant: Option(String),
    english: String,
    transposable: Bool,
    represents_mana: Bool,
    mana_value: Option(Float),
    appears_in_mana_costs: Bool,
    funny: Bool,
    colors: List(Color),
    hybrid: Bool,
    phyrexian: Bool,
    gatherer_alternates: Option(List(String)),
    svg_uri: Option(Uri),
  )
}

pub fn card_symbol_schema() -> glon.JsonSchema(CardSymbol) {
  use symbol <- glon.field("symbol", glon.string())
  use loose_variant <- glon.optional_or_null("loose_variant", glon.string())
  use english <- glon.field("english", glon.string())
  use transposable <- glon.field("transposable", glon.boolean())
  use represents_mana <- glon.field("represents_mana", glon.boolean())
  use mana_value <- glon.optional_or_null("mana_value", glon.number())
  use appears_in_mana_costs <- glon.field(
    "appears_in_mana_costs",
    glon.boolean(),
  )
  use funny <- glon.field("funny", glon.boolean())
  use colors <- glon.field("colors", glon.array(of: color.color_schema()))
  use hybrid <- glon.field("hybrid", glon.boolean())
  use phyrexian <- glon.field("phyrexian", glon.boolean())
  use gatherer_alternates <- glon.optional_or_null(
    "gatherer_alternates",
    glon.array(of: glon.string()),
  )
  use svg_uri <- glon.optional_or_null("svg_uri", common.uri_schema())
  glon.success(CardSymbol(
    symbol:,
    loose_variant:,
    english:,
    transposable:,
    represents_mana:,
    mana_value:,
    appears_in_mana_costs:,
    funny:,
    colors:,
    hybrid:,
    phyrexian:,
    gatherer_alternates:,
    svg_uri:,
  ))
}
