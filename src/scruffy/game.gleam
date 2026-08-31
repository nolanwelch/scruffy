import glon

pub type MtgGame {
  Paper
  Arena
  MtgOnline
  Astral
  Sega
}

pub fn mtg_game_schema() -> glon.JsonSchema(MtgGame) {
  glon.enum_map([
    #("paper", Paper),
    #("arena", Arena),
    #("mtgo", MtgOnline),
    #("astral", Astral),
    #("sega", Sega),
  ])
}
