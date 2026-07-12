import gleam/option.{type Option}
import gleam/uri.{type Uri}
import scruffy/common.{type Uuid}

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

pub type TagType {
  Illustration
  Oracle
}

pub type Tagging {
  Tagging(
    illustration_id: Option(Uuid),
    oracle_id: Option(Uuid),
    weight: TaggingWeight,
    annotation: Option(String),
  )
}

pub type TaggingWeight {
  VeryStrong
  Strong
  Median
  Weak
}
