//// Requests and response decoders for Scryfall's Bulk Data endpoints.
////
//// Build a request with one of the `*_request` functions below, send it
//// with your own HTTP client, then decode its response with the matching
//// `*_response` function.
////
//// See https://scryfall.com/docs/api/bulk-data for the upstream reference.

import gleam/http
import gleam/http/request.{type Request} as _
import gleam/http/response.{type Response}
import scruffy/bulk_data.{type BulkData, type BulkDataType}
import scruffy/client.{type ClientError}
import scruffy/client/request
import scruffy/common.{type Uuid}
import scruffy/scryfall_list.{type ScryfallList}

/// Build a request to list all of the Bulk Data files Scryfall currently
/// offers. Pair the response with `bulk_data_list_response`.
pub fn list_bulk_data_request() -> Request(String) {
  request.new(http.Get, ["bulk-data"])
}

/// Decode a response as a `ScryfallList(BulkData)`. Pairs with
/// `list_bulk_data_request`.
pub fn bulk_data_list_response(
  resp: Response(String),
) -> Result(ScryfallList(BulkData), ClientError) {
  client.decode_response(
    resp,
    then: scryfall_list.scryfall_list_schema(of: bulk_data.bulk_data_schema()),
  )
}

/// Build a request for a single Bulk Data file by its Scryfall ID. Pair the
/// response with `bulk_data_response`.
pub fn get_bulk_data_by_id_request(id: Uuid) -> Request(String) {
  request.new(http.Get, ["bulk-data", id])
}

fn bulk_data_type_to_slug(bulk_data_type: BulkDataType) -> String {
  case bulk_data_type {
    bulk_data.OracleCards -> "oracle_cards"
    bulk_data.UniqueArtwork -> "unique_artwork"
    bulk_data.DefaultCards -> "default_cards"
    bulk_data.AllCards -> "all_cards"
    bulk_data.Rulings -> "rulings"
    bulk_data.ArtTags -> "art_tags"
    bulk_data.OracleTags -> "oracle_tags"
  }
}

/// Build a request for a single Bulk Data file by its type, such as
/// `OracleCards`. Pair the response with `bulk_data_response`.
pub fn get_bulk_data_by_type_request(
  bulk_data_type: BulkDataType,
) -> Request(String) {
  request.new(http.Get, ["bulk-data", bulk_data_type_to_slug(bulk_data_type)])
}

/// Decode a response as a single `BulkData`. Pairs with
/// `get_bulk_data_by_id_request` and `get_bulk_data_by_type_request`.
pub fn bulk_data_response(
  resp: Response(String),
) -> Result(BulkData, ClientError) {
  client.decode_response(resp, then: bulk_data.bulk_data_schema())
}
