//// A type describing Scryfall's Catalog object, a list of Magic-related
//// strings such as artist names or word bank entries.
////
//// See https://scryfall.com/docs/api/catalogs for the upstream reference.

import gleam/option.{type Option}
import gleam/uri.{type Uri}
import glon
import scruffy/common

/// A list of `t` values returned by one of Scryfall's catalog endpoints.
///
/// `uri` is present on the `/catalog/*` endpoints but absent from
/// `/cards/autocomplete`, which returns this same shape otherwise.
pub type Catalog(t) {
  Catalog(uri: Option(Uri), total_values: Int, data: List(t))
}

pub fn catalog_schema(
  of item_schema: glon.JsonSchema(t),
) -> glon.JsonSchema(Catalog(t)) {
  use uri <- glon.optional("uri", common.uri_schema())
  use total_values <- glon.field("total_values", glon.integer())
  use data <- glon.field("data", glon.array(of: item_schema))
  glon.success(Catalog(uri:, total_values:, data:))
}
