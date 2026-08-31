import gleam/option.{type Option}
import gleam/uri.{type Uri}
import glon
import scruffy/common

pub type ImageStatus {
  Missing
  Placeholder
  LowResolution
  HighResolutionScan
}

pub fn image_status_schema() -> glon.JsonSchema(ImageStatus) {
  glon.enum_map([
    #("missing", Missing),
    #("placeholder", Placeholder),
    #("lowres", LowResolution),
    #("highres_scan", HighResolutionScan),
  ])
}

/// The image URIs Scryfall serves for a card or card face, keyed by size or
/// crop. Every field is optional since a card missing its image (or with
/// `image_status` of `Missing`) may omit some or all of them.
pub type ImageUris {
  ImageUris(
    small: Option(Uri),
    normal: Option(Uri),
    large: Option(Uri),
    png: Option(Uri),
    art_crop: Option(Uri),
    border_crop: Option(Uri),
  )
}

pub fn image_uris_schema() -> glon.JsonSchema(ImageUris) {
  use small <- glon.optional("small", common.uri_schema())
  use normal <- glon.optional("normal", common.uri_schema())
  use large <- glon.optional("large", common.uri_schema())
  use png <- glon.optional("png", common.uri_schema())
  use art_crop <- glon.optional("art_crop", common.uri_schema())
  use border_crop <- glon.optional("border_crop", common.uri_schema())
  glon.success(ImageUris(small:, normal:, large:, png:, art_crop:, border_crop:))
}
