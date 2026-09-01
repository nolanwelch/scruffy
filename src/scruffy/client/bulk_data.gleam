//// Functions for calling Scryfall's Bulk Data endpoints.
////
//// Each function builds its request with `scruffy/client/request` and
//// sends it with the `client.Requester` you provide, so what comes back
//// is already the decoded object -- or a `client.ClientError` describing
//// what went wrong.
////
//// See https://scryfall.com/docs/api/bulk-data for the upstream reference.

import gleam/http
import scruffy/bulk_data.{type BulkData, type BulkDataType}
import scruffy/client.{type ClientError, type Requester}
import scruffy/client/request
import scruffy/common.{type Uuid}
import scruffy/scryfall_list.{type ScryfallList}

/// List all of the Bulk Data files Scryfall currently offers.
pub fn list_bulk_data(
  requester: Requester(e),
) -> Result(ScryfallList(BulkData), ClientError(e)) {
  request.new(http.Get, ["bulk-data"])
  |> client.send(
    using: requester,
    then: scryfall_list.scryfall_list_schema(of: bulk_data.bulk_data_schema()),
  )
}

/// Get a single Bulk Data file by its Scryfall ID.
pub fn get_bulk_data_by_id(
  requester: Requester(e),
  id: Uuid,
) -> Result(BulkData, ClientError(e)) {
  request.new(http.Get, ["bulk-data", id])
  |> client.send(using: requester, then: bulk_data.bulk_data_schema())
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

/// Get a single Bulk Data file by its type, such as `OracleCards`.
pub fn get_bulk_data_by_type(
  requester: Requester(e),
  bulk_data_type: BulkDataType,
) -> Result(BulkData, ClientError(e)) {
  request.new(http.Get, ["bulk-data", bulk_data_type_to_slug(bulk_data_type)])
  |> client.send(using: requester, then: bulk_data.bulk_data_schema())
}
