import gleam/option.{type Option}
import scruffy/card_symbol.{type CardSymbol}
import scruffy/color.{type Color}
import scruffy/list.{type ScryfallList}

pub fn get_all_symbols() -> ScryfallList(CardSymbol) {
  todo
}

pub fn parse_mana(cost: String, pretty: Option(Bool)) -> ParsedMana {
  todo
}

pub type ParsedMana {
  ParsedManaCost(
    cost: String,
    cmc: Float,
    colors: List(Color),
    colorless: Bool,
    monocolored: Bool,
    multicolored: Bool,
  )
}
