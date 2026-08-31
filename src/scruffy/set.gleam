//// A type describing Scryfall's Set object, a group of related Magic cards
//// such as an expansion or a promotional set.
////
//// See https://scryfall.com/docs/api/sets for the upstream reference.

import gleam/option.{type Option}
import gleam/uri.{type Uri}
import glon
import scruffy/common.{type Uuid}

/// A Magic: The Gathering set.
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

pub fn set_schema() -> glon.JsonSchema(Set) {
  use id <- glon.field("id", common.uuid_schema())
  use code <- glon.field("code", glon.string())
  use mtgo_code <- glon.optional("mtgo_code", glon.string())
  use arena_code <- glon.optional("arena_code", glon.string())
  use tcgplayer_id <- glon.optional("tcgplayer_id", glon.integer())
  use name <- glon.field("name", glon.string())
  use set_type <- glon.field("set_type", set_type_schema())
  use released_at <- glon.optional("released_at", common.date_schema())
  use block_code <- glon.optional("block_code", glon.string())
  use block <- glon.optional("block", glon.string())
  use parent_set_code <- glon.optional("parent_set_code", glon.string())
  use card_count <- glon.field("card_count", glon.integer())
  use printed_size <- glon.optional("printed_size", glon.integer())
  use digital <- glon.field("digital", glon.boolean())
  use foil_only <- glon.field("foil_only", glon.boolean())
  use nonfoil_only <- glon.field("nonfoil_only", glon.boolean())
  use scryfall_uri <- glon.field("scryfall_uri", common.uri_schema())
  use uri <- glon.field("uri", common.uri_schema())
  use icon_svg_uri <- glon.field("icon_svg_uri", common.uri_schema())
  use search_uri <- glon.field("search_uri", common.uri_schema())
  glon.success(Set(
    id:,
    code:,
    mtgo_code:,
    arena_code:,
    tcgplayer_id:,
    name:,
    set_type:,
    released_at:,
    block_code:,
    block:,
    parent_set_code:,
    card_count:,
    printed_size:,
    digital:,
    foil_only:,
    nonfoil_only:,
    scryfall_uri:,
    uri:,
    icon_svg_uri:,
    search_uri:,
  ))
}

/// The category a set belongs to.
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

pub fn set_type_schema() -> glon.JsonSchema(SetType) {
  glon.enum_map([
    #("core", Core),
    #("expansion", Expansion),
    #("masters", Masters),
    #("eternal", Eternal),
    #("alchemy", Alchemy),
    #("masterpiece", Masterpiece),
    #("arsenal", Arsenal),
    #("from_the_vault", FromTheVault),
    #("spellbook", Spellbook),
    #("premium_deck", PremiumDeck),
    #("duel_deck", DuelDeck),
    #("draft_innovation", DraftInnovation),
    #("treasure_chest", TreasureChest),
    #("commander", Commander),
    #("planechase", Planechase),
    #("archenemy", Archenemy),
    #("vanguard", Vanguard),
    #("funny", Funny),
    #("starter", Starter),
    #("box", Box),
    #("promo", Promo),
    #("token", Token),
    #("memorabilia", Memorabilia),
    #("minigame", Minigame),
  ])
}
