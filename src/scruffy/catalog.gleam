import gleam/uri.{type Uri}

pub type Catalog(t) {
  Catalog(uri: Uri, total_values: Int, data: List(t))
}
