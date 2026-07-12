import gleam/option.{type Option}
import gleam/uri.{type Uri}
import scruffy/common.{type Uuid}

pub type Set {
  Set(
    id: Uuid,
    code: String,
    mtgo_code: Option(String),
    arena_code: Option(String),
    tcgplayer_id: Option(Int),
    name: String,
    set_type: SetType,
    // For now, this represents a Unix timestamp in seconds (unless I end up pivoting to some custom type)
    released_at: Option(Int),
    block_code: Option(String),
    block: Option(String),
    parent_set_code: Option(String),
    card_count: Int,
    printed_size: Option(Int),
    digital: Bool,
    foil_only: Bool,
    nonfoil_only: Bool,
    scryfall_uri: Uri,
    uri: Uri,
    icon_svg_uri: Uri,
    search_uri: Uri,
  )
}

pub type SetType {
  Core
  Expansion
  Masters
  Eternal
  Alchemy
  Masterpiece
  Arsenal
  FromTheVault
  Spellbook
  PremiumDeck
  DuelDeck
  DraftInnovation
  TreasureChest
  Commander
  Planechase
  Archenemy
  Vanguard
  Funny
  Starter
  Box
  Promo
  Token
  Memorabilia
  Minigame
}
