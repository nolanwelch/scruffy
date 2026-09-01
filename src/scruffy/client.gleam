//// The plumbing every function in `scruffy/client/*` is built from: send a
//// request, decode the response.
////
//// `scruffy` never picks an HTTP client for you, so it stays usable from
//// both of Gleam's targets: you bring a `Requester`, a plain function that
//// turns a `Request(String)` into a `Response(String)`. On Erlang that's
//// [`gleam_httpc`](https://hexdocs.pm/gleam_httpc/)'s `send`, unchanged:
////
//// ```gleam
//// import gleam/httpc
//// import scruffy/client/cards
////
//// cards.get_card_by_id(httpc.send, "bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd")
//// ```
////
//// A `Requester` has to return its `Response(String)` synchronously, which
//// rules out Promise-based clients such as
//// [`gleam_fetch`](https://hexdocs.pm/gleam_fetch/) on the JavaScript
//// target. There, skip `send` and the `scruffy/client/*` functions: build
//// the request with `scruffy/client/request`, `await` your own client's
//// response, and decode its body with the matching `*_schema()` from
//// `scruffy/*` and `glon.decode`.
////
//// See https://scryfall.com/docs/api for the upstream reference.

import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/json.{type DecodeError}
import gleam/result
import glon.{type JsonSchema}
import scruffy/error.{type ScryfallError}

/// A plain, synchronous function that sends a request and returns its
/// response -- the shape `gleam_httpc`'s `send`, and most other synchronous
/// HTTP clients, already have. Pass one to `send` or to any function in
/// `scruffy/client/*`.
pub type Requester(transport_error) =
  fn(Request(String)) -> Result(Response(String), transport_error)

/// Everything that can go wrong sending a request to Scryfall and decoding
/// its response.
pub type ClientError(transport_error) {
  /// Scryfall responded with a non-2xx status and an accompanying error
  /// object. See https://scryfall.com/docs/api/errors.
  ApiError(ScryfallError)
  /// The `Requester` couldn't complete the request -- whatever its own
  /// error type says went wrong (DNS, connection, TLS, timeout, ...).
  TransportError(transport_error)
  /// Scryfall returned a successful response, but its body didn't decode
  /// into the shape it was expected to have.
  DecodeError(DecodeError)
}

/// Send a request built by `scruffy/client/request` with the given
/// `Requester`, and decode its body with the given schema.
///
/// A non-2xx response is decoded as a `ScryfallError` instead of `schema`,
/// and returned as `Error(ApiError(_))`.
pub fn send(
  req: Request(String),
  using requester: Requester(e),
  then schema: JsonSchema(t),
) -> Result(t, ClientError(e)) {
  use resp <- result.try(req |> requester |> result.map_error(TransportError))

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
