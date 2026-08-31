import gleam/option.{type Option}
import glon

pub type ScryfallError {
  ScryfallError(
    status: Int,
    code: String,
    details: String,
    error_type: Option(String),
    warnings: Option(List(String)),
  )
}

pub fn scryfall_error_schema() -> glon.JsonSchema(ScryfallError) {
  use status <- glon.field("status", glon.integer())
  use code <- glon.field("code", glon.string())
  use details <- glon.field("details", glon.string())
  use error_type <- glon.optional("type", glon.string())
  use warnings <- glon.optional_or_null(
    "warnings",
    glon.array(of: glon.string()),
  )
  glon.success(ScryfallError(status:, code:, details:, error_type:, warnings:))
}
