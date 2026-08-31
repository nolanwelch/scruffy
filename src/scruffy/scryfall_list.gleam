//// A type describing Scryfall's List object, the paginated envelope most
//// Scryfall endpoints wrap their results in.
////
//// See https://scryfall.com/docs/api/lists for the upstream reference.

import gleam/option.{type Option}
import gleam/uri.{type Uri}
import glon
import scruffy/common

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

pub fn scryfall_list_schema(
  of item_schema: glon.JsonSchema(t),
) -> glon.JsonSchema(ScryfallList(t)) {
  use data <- glon.field("data", glon.array(of: item_schema))
  use has_more <- glon.field("has_more", glon.boolean())
  use next_page <- glon.optional_or_null("next_page", common.uri_schema())
  use total_cards <- glon.optional_or_null("total_cards", glon.integer())
  use warnings <- glon.optional_or_null(
    "warnings",
    glon.array(of: glon.string()),
  )
  glon.success(ScryfallList(
    data:,
    has_more:,
    next_page:,
    total_cards:,
    warnings:,
  ))
}
