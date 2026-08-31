import glon

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
