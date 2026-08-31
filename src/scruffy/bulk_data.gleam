//// A type describing Scryfall's Bulk Data object, a description of a
//// downloadable file containing Scryfall's card data.
////
//// See https://scryfall.com/docs/api/bulk-data for the upstream reference.

import gleam/uri.{type Uri}
import scruffy/common.{type Uuid}

/// A description of a downloadable file containing Scryfall data, such as
/// every card object on Scryfall.
pub type BulkData {
  BulkData(
    id: Uuid,
    uri: Uri,
    bulk_data_type: BulkDataType,
    // updated_at represents a Unix timestamp in seconds for now.
    updated_at: Int,
    name: String,
    description: String,
    jsonl_download_uri: Uri,
    compressed_size: Int,
  )
}

/// The kind of data a Bulk Data file contains.
pub type BulkDataType {
  OracleCards
  UniqueArtwork
  DefaultCards
  AllCards
  Rulings
  ArtTags
  OracleTags
}
