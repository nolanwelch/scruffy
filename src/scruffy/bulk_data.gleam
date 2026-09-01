//// A type describing Scryfall's Bulk Data object, a description of a
//// downloadable file containing Scryfall's card data.
////
//// See https://scryfall.com/docs/api/bulk-data for the upstream reference.

import gleam/uri.{type Uri}
import glon
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

pub fn bulk_data_schema() -> glon.JsonSchema(BulkData) {
  use id <- glon.field("id", common.uuid_schema())
  use uri <- glon.field("uri", common.uri_schema())
  use bulk_data_type <- glon.field("type", bulk_data_type_schema())
  use updated_at <- glon.field("updated_at", common.datetime_schema())
  use name <- glon.field("name", glon.string())
  use description <- glon.field("description", glon.string())
  use jsonl_download_uri <- glon.field(
    "jsonl_download_uri",
    common.uri_schema(),
  )
  use compressed_size <- glon.field("compressed_size", glon.integer())
  glon.success(BulkData(
    id:,
    uri:,
    bulk_data_type:,
    updated_at:,
    name:,
    description:,
    jsonl_download_uri:,
    compressed_size:,
  ))
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

pub fn bulk_data_type_schema() -> glon.JsonSchema(BulkDataType) {
  glon.enum_map([
    #("oracle_cards", OracleCards),
    #("unique_artwork", UniqueArtwork),
    #("default_cards", DefaultCards),
    #("all_cards", AllCards),
    #("rulings", Rulings),
    #("art_tags", ArtTags),
    #("oracle_tags", OracleTags),
  ])
}
