import glon
import scruffy/common.{type Uuid}

pub type Ruling {
  Ruling(
    oracle_id: Uuid,
    source: RulingSource,
    // published_at represents a Unix timestamp in seconds for now.
    published_at: Int,
    comment: String,
  )
}

pub fn ruling_schema() -> glon.JsonSchema(Ruling) {
  use oracle_id <- glon.field("oracle_id", common.uuid_schema())
  use source <- glon.field("source", ruling_source_schema())
  use published_at <- glon.field("published_at", common.date_schema())
  use comment <- glon.field("comment", glon.string())
  glon.success(Ruling(oracle_id:, source:, published_at:, comment:))
}

pub type RulingSource {
  Wotc
  Scryfall
}

pub fn ruling_source_schema() -> glon.JsonSchema(RulingSource) {
  glon.enum_map([#("wotc", Wotc), #("scryfall", Scryfall)])
}
