import gleam/uri.{type Uri}
import glon
import scruffy/common

pub type Catalog(t) {
  Catalog(uri: Uri, total_values: Int, data: List(t))
}

pub fn catalog_schema(
  of item_schema: glon.JsonSchema(t),
) -> glon.JsonSchema(Catalog(t)) {
  use uri <- glon.field("uri", common.uri_schema())
  use total_values <- glon.field("total_values", glon.integer())
  use data <- glon.field("data", glon.array(of: item_schema))
  glon.success(Catalog(uri:, total_values:, data:))
}
