//// A type describing Scryfall's Tag object, used to group cards or
//// illustrations by community-curated Oracle and illustration tags.
////
//// See https://scryfall.com/docs/api/tags for the upstream reference.

import gleam/option.{type Option}
import gleam/uri.{type Uri}
import scruffy/common.{type Uuid}

/// A tag that can be applied to cards or illustrations.
pub type Tag {
  Tag(
    id: Uuid,
    slug: String,
    label: String,
    uri: Uri,
    tag_type: TagType,
    description: Option(String),
    parent_ids: Option(List(Uuid)),
    child_ids: Option(List(Uuid)),
    aliases: Option(List(String)),
    taggings: List(Tagging),
  )
}

/// Whether a tag applies to a card's Oracle text or its illustration.
pub type TagType {
  Illustration
  Oracle
}

/// An application of a `Tag` to a specific card or illustration.
pub type Tagging {
  Tagging(
    illustration_id: Option(Uuid),
    oracle_id: Option(Uuid),
    weight: TaggingWeight,
    annotation: Option(String),
  )
}

/// How strongly a tag applies to what it's tagging.
pub type TaggingWeight {
  VeryStrong
  Strong
  Median
  Weak
}
