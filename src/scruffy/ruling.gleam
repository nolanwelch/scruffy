import scruffy/common.{type Uuid}

pub type Ruling {
  // published_at represents a Unix timestamp in seconds for now.
  Ruling(oracle_id: Uuid, source: String, published_at: Int, comment: String)
}
