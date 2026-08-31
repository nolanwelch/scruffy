//// A small factory for building the `Request(String)` values that hit
//// Scryfall's REST API.
////
//// `scruffy` models Scryfall's objects and how to ask for them, but it
//// deliberately never performs I/O itself -- pick whatever HTTP client
//// suits your project (`gleam_httpc`, `gleam_fetch`, ...) and send the
//// `Request(String)` these functions hand back through it. The response
//// body can then be handed to the matching `*_schema()` decoder in
//// `scruffy/*`.
////
//// Every function in `scruffy/client/*` is built from the same two pieces
//// provided here: `new`, which lays down the skeleton every Scryfall
//// request shares (host, scheme, the `accept` header its API guidelines
//// ask for), and the `with_*` decorators, which layer on whatever is
//// specific to one endpoint -- a query string or a JSON body. Endpoint
//// functions read as a pipeline built from these two pieces, e.g.:
////
//// ```gleam
//// pub fn get_card_by_id(id: Uuid) -> Request(String) {
////   request.new(http.Get, ["cards", id])
//// }
////
//// pub fn autocomplete_card_name(
////   q: String,
////   include_extras: Option(Bool),
//// ) -> Request(String) {
////   request.new(http.Get, ["cards", "autocomplete"])
////   |> request.with_query([
////     #("q", option.Some(q)),
////     #("include_extras", option.map(include_extras, bool_to_string)),
////   ])
//// }
//// ```
////
//// See https://scryfall.com/docs/api for the upstream reference.

import gleam/http.{type Method}
import gleam/http/request.{type Request}
import gleam/json.{type Json}
import gleam/list
import gleam/option.{type Option}
import gleam/string
import gleam/uri

/// The host every Scryfall request targets, over HTTPS.
pub const host = "api.scryfall.com"

/// Build the skeleton of a request to a Scryfall endpoint: `method` against
/// `https://api.scryfall.com/<path_segments, joined and percent-encoded>`,
/// with the `accept` header Scryfall's API guidelines ask every client to
/// send.
///
/// `path_segments` are individually percent-encoded, so pass the raw path
/// components (a card name, a set code, a UUID) rather than a pre-built
/// path string.
///
/// Layer on whatever else the endpoint needs with `with_query` or
/// `with_json_body`. Scryfall also asks that real applications built on top
/// of a client library identify themselves with their own descriptive
/// `user-agent`, which this factory leaves for the caller to add.
pub fn new(method: Method, path_segments: List(String)) -> Request(String) {
  let path =
    path_segments
    |> list.map(uri.percent_encode)
    |> string.join(with: "/")

  request.new()
  |> request.set_method(method)
  |> request.set_host(host)
  |> request.set_path("/" <> path)
  |> request.set_header("accept", "application/json")
}

/// Add a query string built from an endpoint's optional parameters,
/// dropping the ones left unset and percent-encoding the rest.
///
/// This is the piece that lets each endpoint describe its query parameters
/// as a flat list of `#(name, Option(String))` pairs and leave the
/// filtering and encoding to this module and `gleam_http`.
pub fn with_query(
  req: Request(String),
  params: List(#(String, Option(String))),
) -> Request(String) {
  let present =
    list.filter_map(params, fn(param) {
      case param {
        #(name, option.Some(value)) -> Ok(#(name, value))
        #(_, option.None) -> Error(Nil)
      }
    })

  case present {
    [] -> req
    _ -> request.set_query(req, present)
  }
}

/// Set a request's body to a JSON document, for the handful of Scryfall
/// endpoints (such as `POST /cards/collection`) that take one.
pub fn with_json_body(req: Request(String), body: Json) -> Request(String) {
  req
  |> request.set_header("content-type", "application/json")
  |> request.set_body(json.to_string(body))
}
