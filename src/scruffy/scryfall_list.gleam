//// A type describing Scryfall's List object, the paginated envelope most
//// Scryfall endpoints wrap their results in.
////
//// See https://scryfall.com/docs/api/lists for the upstream reference.

import gleam/option.{type Option}
import gleam/uri.{type Uri}

/// A single page of `t` values returned by a Scryfall list endpoint.
pub type ScryfallList(t) {
  ScryfallList(
    data: List(t),
    has_more: Bool,
    next_page: Option(Uri),
    total_cards: Option(Int),
    warnings: Option(List(String)),
  )
}
