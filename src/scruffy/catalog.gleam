//// A type describing Scryfall's Catalog object, a list of Magic-related
//// strings such as artist names or word bank entries.
////
//// See https://scryfall.com/docs/api/catalogs for the upstream reference.

import gleam/uri.{type Uri}

/// A list of `t` values returned by one of Scryfall's catalog endpoints.
pub type Catalog(t) {
  Catalog(uri: Uri, total_values: Int, data: List(t))
}
