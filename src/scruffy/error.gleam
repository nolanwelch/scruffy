//// A type describing Scryfall's Error object, returned whenever a request
//// to the API is unsuccessful.
////
//// See https://scryfall.com/docs/api/errors for the upstream reference.

import gleam/option.{type Option}

/// An error response from the Scryfall API.
pub type ScryfallError {
  ScryfallError(
    status: Int,
    code: String,
    details: String,
    error_type: Option(String),
    warnings: Option(List(String)),
  )
}
