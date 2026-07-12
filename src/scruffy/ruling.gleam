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

pub type RulingSource {
  Wotc
  Scryfall
}
