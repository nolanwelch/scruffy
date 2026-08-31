//// A type describing Magic's five colors, used throughout the Scryfall API
//// for fields like `colors` and `color_identity`.

import glon

/// One of Magic's five colors, or colorless.
pub type Color {
  White
  Blue
  Black
  Red
  Green
  Colorless
}

pub fn color_schema() -> glon.JsonSchema(Color) {
  glon.enum_map([
    #("W", White),
    #("U", Blue),
    #("B", Black),
    #("R", Red),
    #("G", Green),
    #("C", Colorless),
  ])
}
