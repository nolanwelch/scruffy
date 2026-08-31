//// A type describing Scryfall's Ruling object, an official ruling on how a
//// card's rules text works.
////
//// See https://scryfall.com/docs/api/rulings for the upstream reference.

import scruffy/common.{type Uuid}

/// An official ruling clarifying how a card works.
pub type Ruling {
  Ruling(
    oracle_id: Uuid,
    source: RulingSource,
    // published_at represents a Unix timestamp in seconds for now.
    published_at: Int,
    comment: String,
  )
}

/// Who issued a ruling.
pub type RulingSource {
  Wotc
  Scryfall
}
