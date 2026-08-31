import gleam/option.{type Option}
import gleam/uri.{type Uri}
import glon
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

pub fn tag_schema() -> glon.JsonSchema(Tag) {
  use id <- glon.field("id", common.uuid_schema())
  use slug <- glon.field("slug", glon.string())
  use label <- glon.field("label", glon.string())
  use uri <- glon.field("uri", common.uri_schema())
  use tag_type <- glon.field("type", tag_type_schema())
  use description <- glon.optional("description", glon.string())
  use parent_ids <- glon.optional(
    "parent_ids",
    glon.array(of: common.uuid_schema()),
  )
  use child_ids <- glon.optional(
    "child_ids",
    glon.array(of: common.uuid_schema()),
  )
  use aliases <- glon.optional("aliases", glon.array(of: glon.string()))
  use taggings <- glon.field("taggings", glon.array(of: tagging_schema()))
  glon.success(Tag(
    id:,
    slug:,
    label:,
    uri:,
    tag_type:,
    description:,
    parent_ids:,
    child_ids:,
    aliases:,
    taggings:,
  ))
}

pub type TagType {
  Illustration
  Oracle
}

pub fn tag_type_schema() -> glon.JsonSchema(TagType) {
  glon.enum_map([#("illustration", Illustration), #("oracle", Oracle)])
}

pub type Tagging {
  Tagging(
    illustration_id: Option(Uuid),
    oracle_id: Option(Uuid),
    weight: TaggingWeight,
    annotation: Option(String),
  )
}

pub fn tagging_schema() -> glon.JsonSchema(Tagging) {
  use illustration_id <- glon.optional("illustration_id", common.uuid_schema())
  use oracle_id <- glon.optional("oracle_id", common.uuid_schema())
  use weight <- glon.field("weight", tagging_weight_schema())
  use annotation <- glon.optional("annotation", glon.string())
  glon.success(Tagging(illustration_id:, oracle_id:, weight:, annotation:))
}

pub type TaggingWeight {
  VeryStrong
  Strong
  Median
  Weak
}

pub fn tagging_weight_schema() -> glon.JsonSchema(TaggingWeight) {
  glon.enum_map([
    #("very_strong", VeryStrong),
    #("strong", Strong),
    #("median", Median),
    #("weak", Weak),
  ])
}
