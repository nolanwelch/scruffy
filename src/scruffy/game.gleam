//// A type describing the games a card printing is available in.

import glon

/// A game a card printing is legal to play in.
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
