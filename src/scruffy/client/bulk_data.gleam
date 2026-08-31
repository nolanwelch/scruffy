//// Stub methods for calling Scryfall's Bulk Data endpoints.
////
//// See https://scryfall.com/docs/api/bulk-data for the upstream reference.

import gleam/option.{type Option}
import scruffy/bulk_data.{type BulkData, type BulkDataType}
import scruffy/common.{type Uuid}
import scruffy/scryfall_list.{type ScryfallList}

/// List all of the Bulk Data files Scryfall currently offers.
pub fn list_bulk_data() -> ScryfallList(BulkData) {
  todo
}

/// Get a single Bulk Data file by its Scryfall ID.
pub fn get_bulk_data_by_id(id: Uuid) -> Option(BulkData) {
  todo
}

/// Get a single Bulk Data file by its type, such as `OracleCards`.
pub fn get_bulk_data_by_type(bulk_data_type: BulkDataType) -> Option(BulkData) {
  todo
}
