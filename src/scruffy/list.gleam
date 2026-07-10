import gleam/option.{type Option}
import gleam/uri.{type Uri}

pub type ScryfallList(t) {
  ScryfallList(
    data: List(t),
    has_more: Bool,
    next_page: Option(Uri),
    total_cards: Option(Int),
    warnings: Option(List(String)),
  )
}
