//// A type describing Scryfall's Card Symbol object, used to render mana
//// costs, the tap symbol, and other symbols found in oracle text.
////
//// See https://scryfall.com/docs/api/card-symbols for the upstream reference.

import gleam/option.{type Option}
import gleam/uri.{type Uri}
import scruffy/color.{type Color}

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
