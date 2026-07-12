import gleam/option.{type Option}
import gleam/uri.{type Uri}
import scruffy/color.{type Color}

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
