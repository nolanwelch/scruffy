//// Types describing Scryfall's Card object and the smaller types it is
//// made up of.
////
//// See https://scryfall.com/docs/api/cards for the upstream reference.

import gleam/option.{type Option}
import gleam/uri.{type Uri}
import scruffy/color.{type Color}
import scruffy/common.{type Uuid}
import scruffy/frame.{type Frame, type FrameEffect}
import scruffy/game.{type MtgGame}
import scruffy/image.{type ImageStatus}
import scruffy/language.{type Language}
import scruffy/layout.{type Layout}

/// A single Magic: The Gathering card, as returned by the Scryfall API.
pub type Card {
  Card(
    arena_id: Option(Int),
    id: Uuid,
    lang: Language,
    mtgo_id: Option(Int),
    mtgo_foil_id: Option(Int),
    multiverse_ids: Option(List(Int)),
    resource_id: Option(String),
    tcgplayer_id: Option(Int),
    tcgplayer_etched_id: Option(Int),
    cardmarket_id: Option(Int),
    layout: Layout,
    oracle_id: Option(Uuid),
    prints_search_uri: Uri,
    rulings_uri: Uri,
    scryfall_uri: Uri,
    uri: Uri,
    all_parts: Option(List(RelatedCardObject)),
    card_faces: Option(List(CardFace)),
    cmc: Float,
    color_identity: List(Color),
    color_indicator: Option(List(Color)),
    colors: Option(List(Color)),
    defense: Option(String),
    edhrec_rank: Option(Int),
    game_changer: Option(Bool),
    hand_modifier: Option(String),
    // This could probably be an enum.
    keywords: List(String),
    // List? Unclear, should check what an API call returns
    legalities: List(CardLegality),
    life_modifier: Option(String),
    loyalty: Option(String),
    mana_cost: Option(String),
    name: String,
    oracle_text: Option(String),
    penny_rank: Option(Int),
    power: Option(String),
    produced_mana: Option(List(Color)),
    reserved: Bool,
    toughness: Option(String),
    type_line: String,
    artist: Option(String),
    artist_ids: Option(List(Uuid)),
    attraction_lights: Option(List(Int)),
    booster: Bool,
    border_color: CardBorderColor,
    card_back_id: Uuid,
    collector_number: String,
    content_warning: Option(Bool),
    digital: Bool,
    finishes: List(CardFinish),
    flavor_name: Option(String),
    flavor_text: Option(String),
    frame_effects: Option(List(FrameEffect)),
    frame: Frame,
    full_art: Bool,
    games: List(MtgGame),
    highres_image: Bool,
    illustration_id: Option(Uuid),
    image_status: ImageStatus,
    image_uris: Option(List(Uri)),
    oversized: Bool,
    prices: CardPrice,
    printed_name: Option(String),
    printed_text: Option(String),
    printed_type_line: Option(String),
    promo: Bool,
    promo_types: Option(List(String)),
    purchase_uris: Option(List(Uri)),
    rarity: CardRarity,
    related_uris: List(Uri),
    released_at: Int,
    reprint: Bool,
    scryfall_set_uri: Uri,
    set_name: String,
    set_search_uri: Uri,
    set_type: String,
    set_uri: Uri,
    set: String,
    set_id: Uuid,
    story_spotlight: Bool,
    textless: Bool,
    variation: Bool,
    variation_of: Option(Uuid),
    security_stamp: Option(SecurityStamp),
    watermark: Option(String),
    preview: Option(CardPreview),
  )
}

/// A card's legal status in a particular format.
pub type CardLegality {
  Legal
  NotLegal
  Restricted
  Banned
}

/// One face of a multi-faced card (e.g. a transform or split card).
pub type CardFace {
  CardFace(
    artist: Option(String),
    artist_id: Option(Uuid),
    cmc: Option(Float),
    color_indicator: Option(List(Color)),
    colors: Option(List(Color)),
    defense: Option(String),
    flavor_text: Option(String),
    illustration_id: Option(Uuid),
    image_uris: Option(List(Uri)),
    layout: Option(Layout),
    loyalty: Option(String),
    mana_cost: String,
    name: String,
    oracle_id: Option(Uuid),
    oracle_text: Option(String),
    power: Option(String),
    printed_name: Option(String),
    printed_text: Option(String),
    printed_type_line: Option(String),
    toughness: Option(String),
    type_line: Option(String),
    watermark: Option(String),
  )
}

/// A reference to a card related to this one, such as a token it creates.
pub type RelatedCardObject {
  RelatedCardObject(
    id: Uuid,
    component: RelatedCardComponent,
    name: String,
    type_line: String,
    uri: Uri,
  )
}

/// How a `RelatedCardObject` relates to the card that references it.
pub type RelatedCardComponent {
  Token
  MeldPart
  MeldResult
  ComboPiece
}

/// The color of a card's border.
pub type CardBorderColor {
  Black
  White
  Borderless
  Yellow
  Silver
  Gold
}

/// A physical finish a card printing is available in.
pub type CardFinish {
  Foil
  NonFoil
  Etched
}

/// A card's prices in various currencies, as decimal strings.
pub type CardPrice {
  CardPrice(
    usd: String,
    usd_foil: String,
    usd_etched: String,
    eur: String,
    eur_foil: String,
    eur_etched: String,
    tix: String,
  )
}

/// A card's rarity.
pub type CardRarity {
  Common
  Uncommon
  Rare
  Special
  Mythic
  Bonus
}

/// The security stamp printed on a card, if any.
pub type SecurityStamp {
  Oval
  Triangle
  Acorn
  Circle
  Arena
  Heart
}

/// Details of a card's preview / spoiler, if it was previewed before its
/// set released.
pub type CardPreview {
  CardPreview(
    previewed_at: Option(Int),
    source_uri: Option(Uri),
    source: Option(String),
  )
}
