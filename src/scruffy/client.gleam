//// A Scryfall API client: build a request with `scruffy/client/request`,
//// hand it to `send`, and get back the decoded object -- or an error
//// describing what went wrong -- directly. Every function under
//// `scruffy/client/*` is already wired up this way, so calling one of them
//// is enough to talk to Scryfall out of the box.
////
//// This uses `gleam_httpc`, Gleam's own binding to the `httpc` client
//// shipped with Erlang/OTP, which is why `scruffy` targets Erlang. If you
//// need to send these requests some other way (say, from the JavaScript
//// target), build them with `scruffy/client/request` directly and decode
//// the response body yourself with the matching `*_schema()` from
//// `scruffy/*` -- `send` below is a three-step wrapper you can reimplement
//// with any client capable of producing a `Response(String)`.
////
//// See https://scryfall.com/docs/api for the upstream reference.

import gleam/http/request.{type Request}
import gleam/httpc.{type HttpError}
import gleam/json.{type DecodeError}
import gleam/result
import glon.{type JsonSchema}
import scruffy/error.{type ScryfallError}

/// Everything that can go wrong sending a request to Scryfall and decoding
/// its response.
pub type ClientError {
  /// Scryfall responded with a non-2xx status and an accompanying error
  /// object. See https://scryfall.com/docs/api/errors.
  ApiError(ScryfallError)
  /// The request couldn't be completed at the transport level -- a DNS,
  /// connection, TLS, or timeout failure.
  TransportError(HttpError)
  /// Scryfall returned a successful response, but its body didn't decode
  /// into the shape it was expected to have.
  DecodeError(DecodeError)
}

/// Send a request built by `scruffy/client/request` and decode its body
/// with the given schema.
///
/// A non-2xx response is decoded as a `ScryfallError` instead of `schema`,
/// and returned as `Error(ApiError(_))`.
pub fn send(
  req: Request(String),
  schema: JsonSchema(t),
) -> Result(t, ClientError) {
  use resp <- result.try(
    req
    |> httpc.send
    |> result.map_error(TransportError),
  )

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
