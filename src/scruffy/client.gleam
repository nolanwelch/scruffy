//// The plumbing every function in `scruffy/client/*` is built from:
//// deciding whether a response succeeded, and decoding its body.
////
//// `scruffy` never performs I/O itself, so it never picks an HTTP client
//// for you. Each endpoint in `scruffy/client/*` instead comes as a pair of
//// plain functions: a `*_request` that builds a `Request(String)`, and a
//// `*_response` that turns the `Response(String)` you got back -- from
//// whatever client you sent that request with -- into typed data. Send the
//// request however suits your project (`gleam_httpc` on Erlang,
//// `gleam_fetch` on JavaScript, or anything else that speaks
//// `gleam/http`), then hand the response to the matching `*_response`
//// function.
////
//// ```gleam
//// import gleam/httpc
//// import scruffy/client/cards
////
//// let assert Ok(resp) =
////   cards.get_card_by_id_request("bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd")
////   |> httpc.send
//// let assert Ok(card) = cards.card_response(resp)
//// ```
////
//// See https://scryfall.com/docs/api for the upstream reference.

import gleam/http/response.{type Response}
import gleam/json.{type DecodeError}
import gleam/result
import glon.{type JsonSchema}
import scruffy/error.{type ScryfallError}

/// Everything that can go wrong decoding a response from Scryfall. Sending
/// the request itself is on you and your own HTTP client -- this only
/// covers what happens once you have a `Response(String)` back.
pub type ClientError {
  /// Scryfall responded with a non-2xx status and an accompanying error
  /// object. See https://scryfall.com/docs/api/errors.
  ApiError(ScryfallError)
  /// Scryfall returned a successful response, but its body didn't decode
  /// into the shape it was expected to have.
  DecodeError(DecodeError)
}

/// Decode a `Response(String)` from Scryfall with the given schema.
///
/// A non-2xx response is decoded as a `ScryfallError` instead of `schema`,
/// and returned as `Error(ApiError(_))`. Every `*_response` function in
/// `scruffy/client/*` is built from this.
pub fn decode_response(
  resp: Response(String),
  then schema: JsonSchema(t),
) -> Result(t, ClientError) {
  case resp.status >= 200 && resp.status < 300 {
    True ->
      glon.decode(schema, from: resp.body)
      |> result.map_error(DecodeError)
    False -> {
      use scryfall_error <- result.try(
        glon.decode(error.scryfall_error_schema(), from: resp.body)
        |> result.map_error(DecodeError),
      )
      Error(ApiError(scryfall_error))
    }
  }
}
