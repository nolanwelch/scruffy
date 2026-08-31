import gleam/option.{type Option}
import gleam/uri.{type Uri}
import glon
import scruffy/color.{type Color}
import scruffy/common.{type Uuid}
import scruffy/frame.{type Frame, type FrameEffect}
import scruffy/game.{type MtgGame}
import scruffy/image.{type ImageStatus, type ImageUris}
import scruffy/language.{type Language}
import scruffy/layout.{type Layout}

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
    legalities: Legalities,
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
    // Absent on some multi-faced layouts (e.g. transform cards).
    card_back_id: Option(Uuid),
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
    image_uris: Option(ImageUris),
    oversized: Bool,
    prices: CardPrice,
    printed_name: Option(String),
    printed_text: Option(String),
    printed_type_line: Option(String),
    promo: Bool,
    promo_types: Option(List(String)),
    purchase_uris: Option(PurchaseUris),
    rarity: CardRarity,
    related_uris: RelatedUris,
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

pub fn card_schema() -> glon.JsonSchema(Card) {
  use arena_id <- glon.optional("arena_id", glon.integer())
  use id <- glon.field("id", common.uuid_schema())
  use lang <- glon.field("lang", language.language_schema())
  use mtgo_id <- glon.optional("mtgo_id", glon.integer())
  use mtgo_foil_id <- glon.optional("mtgo_foil_id", glon.integer())
  use multiverse_ids <- glon.optional(
    "multiverse_ids",
    glon.array(of: glon.integer()),
  )
  use resource_id <- glon.optional("resource_id", glon.string())
  use tcgplayer_id <- glon.optional("tcgplayer_id", glon.integer())
  use tcgplayer_etched_id <- glon.optional(
    "tcgplayer_etched_id",
    glon.integer(),
  )
  use cardmarket_id <- glon.optional("cardmarket_id", glon.integer())
  use layout <- glon.field("layout", layout.layout_schema())
  use oracle_id <- glon.optional("oracle_id", common.uuid_schema())
  use prints_search_uri <- glon.field("prints_search_uri", common.uri_schema())
  use rulings_uri <- glon.field("rulings_uri", common.uri_schema())
  use scryfall_uri <- glon.field("scryfall_uri", common.uri_schema())
  use uri <- glon.field("uri", common.uri_schema())
  use all_parts <- glon.optional(
    "all_parts",
    glon.array(of: related_card_object_schema()),
  )
  use card_faces <- glon.optional(
    "card_faces",
    glon.array(of: card_face_schema()),
  )
  use cmc <- glon.field("cmc", glon.number())
  use color_identity <- glon.field(
    "color_identity",
    glon.array(of: color.color_schema()),
  )
  use color_indicator <- glon.optional(
    "color_indicator",
    glon.array(of: color.color_schema()),
  )
  use colors <- glon.optional("colors", glon.array(of: color.color_schema()))
  use defense <- glon.optional("defense", glon.string())
  use edhrec_rank <- glon.optional("edhrec_rank", glon.integer())
  use game_changer <- glon.optional("game_changer", glon.boolean())
  use hand_modifier <- glon.optional("hand_modifier", glon.string())
  use keywords <- glon.field("keywords", glon.array(of: glon.string()))
  use legalities <- glon.field("legalities", legalities_schema())
  use life_modifier <- glon.optional("life_modifier", glon.string())
  use loyalty <- glon.optional("loyalty", glon.string())
  use mana_cost <- glon.optional("mana_cost", glon.string())
  use name <- glon.field("name", glon.string())
  use oracle_text <- glon.optional("oracle_text", glon.string())
  use penny_rank <- glon.optional("penny_rank", glon.integer())
  use power <- glon.optional("power", glon.string())
  use produced_mana <- glon.optional(
    "produced_mana",
    glon.array(of: color.color_schema()),
  )
  use reserved <- glon.field("reserved", glon.boolean())
  use toughness <- glon.optional("toughness", glon.string())
  use type_line <- glon.field("type_line", glon.string())
  use artist <- glon.optional("artist", glon.string())
  use artist_ids <- glon.optional(
    "artist_ids",
    glon.array(of: common.uuid_schema()),
  )
  use attraction_lights <- glon.optional(
    "attraction_lights",
    glon.array(of: glon.integer()),
  )
  use booster <- glon.field("booster", glon.boolean())
  use border_color <- glon.field("border_color", card_border_color_schema())
  use card_back_id <- glon.optional("card_back_id", common.uuid_schema())
  use collector_number <- glon.field("collector_number", glon.string())
  use content_warning <- glon.optional("content_warning", glon.boolean())
  use digital <- glon.field("digital", glon.boolean())
  use finishes <- glon.field("finishes", glon.array(of: card_finish_schema()))
  use flavor_name <- glon.optional("flavor_name", glon.string())
  use flavor_text <- glon.optional("flavor_text", glon.string())
  use frame_effects <- glon.optional(
    "frame_effects",
    glon.array(of: frame.frame_effect_schema()),
  )
  use frame <- glon.field("frame", frame.frame_schema())
  use full_art <- glon.field("full_art", glon.boolean())
  use games <- glon.field("games", glon.array(of: game.mtg_game_schema()))
  use highres_image <- glon.field("highres_image", glon.boolean())
  use illustration_id <- glon.optional("illustration_id", common.uuid_schema())
  use image_status <- glon.field("image_status", image.image_status_schema())
  use image_uris <- glon.optional("image_uris", image.image_uris_schema())
  use oversized <- glon.field("oversized", glon.boolean())
  use prices <- glon.field("prices", card_price_schema())
  use printed_name <- glon.optional("printed_name", glon.string())
  use printed_text <- glon.optional("printed_text", glon.string())
  use printed_type_line <- glon.optional("printed_type_line", glon.string())
  use promo <- glon.field("promo", glon.boolean())
  use promo_types <- glon.optional("promo_types", glon.array(of: glon.string()))
  use purchase_uris <- glon.optional("purchase_uris", purchase_uris_schema())
  use rarity <- glon.field("rarity", card_rarity_schema())
  use related_uris <- glon.field("related_uris", related_uris_schema())
  use released_at <- glon.field("released_at", common.date_schema())
  use reprint <- glon.field("reprint", glon.boolean())
  use scryfall_set_uri <- glon.field("scryfall_set_uri", common.uri_schema())
  use set_name <- glon.field("set_name", glon.string())
  use set_search_uri <- glon.field("set_search_uri", common.uri_schema())
  use set_type <- glon.field("set_type", glon.string())
  use set_uri <- glon.field("set_uri", common.uri_schema())
  use set <- glon.field("set", glon.string())
  use set_id <- glon.field("set_id", common.uuid_schema())
  use story_spotlight <- glon.field("story_spotlight", glon.boolean())
  use textless <- glon.field("textless", glon.boolean())
  use variation <- glon.field("variation", glon.boolean())
  use variation_of <- glon.optional("variation_of", common.uuid_schema())
  use security_stamp <- glon.optional("security_stamp", security_stamp_schema())
  use watermark <- glon.optional("watermark", glon.string())
  use preview <- glon.optional("preview", card_preview_schema())
  glon.success(Card(
    arena_id:,
    id:,
    lang:,
    mtgo_id:,
    mtgo_foil_id:,
    multiverse_ids:,
    resource_id:,
    tcgplayer_id:,
    tcgplayer_etched_id:,
    cardmarket_id:,
    layout:,
    oracle_id:,
    prints_search_uri:,
    rulings_uri:,
    scryfall_uri:,
    uri:,
    all_parts:,
    card_faces:,
    cmc:,
    color_identity:,
    color_indicator:,
    colors:,
    defense:,
    edhrec_rank:,
    game_changer:,
    hand_modifier:,
    keywords:,
    legalities:,
    life_modifier:,
    loyalty:,
    mana_cost:,
    name:,
    oracle_text:,
    penny_rank:,
    power:,
    produced_mana:,
    reserved:,
    toughness:,
    type_line:,
    artist:,
    artist_ids:,
    attraction_lights:,
    booster:,
    border_color:,
    card_back_id:,
    collector_number:,
    content_warning:,
    digital:,
    finishes:,
    flavor_name:,
    flavor_text:,
    frame_effects:,
    frame:,
    full_art:,
    games:,
    highres_image:,
    illustration_id:,
    image_status:,
    image_uris:,
    oversized:,
    prices:,
    printed_name:,
    printed_text:,
    printed_type_line:,
    promo:,
    promo_types:,
    purchase_uris:,
    rarity:,
    related_uris:,
    released_at:,
    reprint:,
    scryfall_set_uri:,
    set_name:,
    set_search_uri:,
    set_type:,
    set_uri:,
    set:,
    set_id:,
    story_spotlight:,
    textless:,
    variation:,
    variation_of:,
    security_stamp:,
    watermark:,
    preview:,
  ))
}

pub type CardLegality {
  Legal
  NotLegal
  Restricted
  Banned
}

pub fn card_legality_schema() -> glon.JsonSchema(CardLegality) {
  glon.enum_map([
    #("legal", Legal),
    #("not_legal", NotLegal),
    #("restricted", Restricted),
    #("banned", Banned),
  ])
}

/// A card's legality across every format Scryfall currently tracks.
///
/// Scryfall represents this as an object keyed by format name rather than a
/// list, so each known format gets its own field here. New formats will
/// need a new field added when Scryfall starts reporting them.
pub type Legalities {
  Legalities(
    standard: CardLegality,
    future: CardLegality,
    historic: CardLegality,
    timeless: CardLegality,
    gladiator: CardLegality,
    pioneer: CardLegality,
    modern: CardLegality,
    legacy: CardLegality,
    pauper: CardLegality,
    vintage: CardLegality,
    penny: CardLegality,
    commander: CardLegality,
    oathbreaker: CardLegality,
    standardbrawl: CardLegality,
    brawl: CardLegality,
    competitivebrawl: CardLegality,
    alchemy: CardLegality,
    paupercommander: CardLegality,
    duel: CardLegality,
    oldschool: CardLegality,
    premodern: CardLegality,
    predh: CardLegality,
    tlr: CardLegality,
  )
}

pub fn legalities_schema() -> glon.JsonSchema(Legalities) {
  use standard <- glon.field("standard", card_legality_schema())
  use future <- glon.field("future", card_legality_schema())
  use historic <- glon.field("historic", card_legality_schema())
  use timeless <- glon.field("timeless", card_legality_schema())
  use gladiator <- glon.field("gladiator", card_legality_schema())
  use pioneer <- glon.field("pioneer", card_legality_schema())
  use modern <- glon.field("modern", card_legality_schema())
  use legacy <- glon.field("legacy", card_legality_schema())
  use pauper <- glon.field("pauper", card_legality_schema())
  use vintage <- glon.field("vintage", card_legality_schema())
  use penny <- glon.field("penny", card_legality_schema())
  use commander <- glon.field("commander", card_legality_schema())
  use oathbreaker <- glon.field("oathbreaker", card_legality_schema())
  use standardbrawl <- glon.field("standardbrawl", card_legality_schema())
  use brawl <- glon.field("brawl", card_legality_schema())
  use competitivebrawl <- glon.field("competitivebrawl", card_legality_schema())
  use alchemy <- glon.field("alchemy", card_legality_schema())
  use paupercommander <- glon.field("paupercommander", card_legality_schema())
  use duel <- glon.field("duel", card_legality_schema())
  use oldschool <- glon.field("oldschool", card_legality_schema())
  use premodern <- glon.field("premodern", card_legality_schema())
  use predh <- glon.field("predh", card_legality_schema())
  use tlr <- glon.field("tlr", card_legality_schema())
  glon.success(Legalities(
    standard:,
    future:,
    historic:,
    timeless:,
    gladiator:,
    pioneer:,
    modern:,
    legacy:,
    pauper:,
    vintage:,
    penny:,
    commander:,
    oathbreaker:,
    standardbrawl:,
    brawl:,
    competitivebrawl:,
    alchemy:,
    paupercommander:,
    duel:,
    oldschool:,
    premodern:,
    predh:,
    tlr:,
  ))
}

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
    image_uris: Option(ImageUris),
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

pub fn card_face_schema() -> glon.JsonSchema(CardFace) {
  use artist <- glon.optional("artist", glon.string())
  use artist_id <- glon.optional("artist_id", common.uuid_schema())
  use cmc <- glon.optional("cmc", glon.number())
  use color_indicator <- glon.optional(
    "color_indicator",
    glon.array(of: color.color_schema()),
  )
  use colors <- glon.optional("colors", glon.array(of: color.color_schema()))
  use defense <- glon.optional("defense", glon.string())
  use flavor_text <- glon.optional("flavor_text", glon.string())
  use illustration_id <- glon.optional("illustration_id", common.uuid_schema())
  use image_uris <- glon.optional("image_uris", image.image_uris_schema())
  use layout <- glon.optional("layout", layout.layout_schema())
  use loyalty <- glon.optional("loyalty", glon.string())
  use mana_cost <- glon.field("mana_cost", glon.string())
  use name <- glon.field("name", glon.string())
  use oracle_id <- glon.optional("oracle_id", common.uuid_schema())
  use oracle_text <- glon.optional("oracle_text", glon.string())
  use power <- glon.optional("power", glon.string())
  use printed_name <- glon.optional("printed_name", glon.string())
  use printed_text <- glon.optional("printed_text", glon.string())
  use printed_type_line <- glon.optional("printed_type_line", glon.string())
  use toughness <- glon.optional("toughness", glon.string())
  use type_line <- glon.optional("type_line", glon.string())
  use watermark <- glon.optional("watermark", glon.string())
  glon.success(CardFace(
    artist:,
    artist_id:,
    cmc:,
    color_indicator:,
    colors:,
    defense:,
    flavor_text:,
    illustration_id:,
    image_uris:,
    layout:,
    loyalty:,
    mana_cost:,
    name:,
    oracle_id:,
    oracle_text:,
    power:,
    printed_name:,
    printed_text:,
    printed_type_line:,
    toughness:,
    type_line:,
    watermark:,
  ))
}

pub type RelatedCardObject {
  RelatedCardObject(
    id: Uuid,
    component: RelatedCardComponent,
    name: String,
    type_line: String,
    uri: Uri,
  )
}

pub fn related_card_object_schema() -> glon.JsonSchema(RelatedCardObject) {
  use id <- glon.field("id", common.uuid_schema())
  use component <- glon.field("component", related_card_component_schema())
  use name <- glon.field("name", glon.string())
  use type_line <- glon.field("type_line", glon.string())
  use uri <- glon.field("uri", common.uri_schema())
  glon.success(RelatedCardObject(id:, component:, name:, type_line:, uri:))
}

pub type RelatedCardComponent {
  Token
  MeldPart
  MeldResult
  ComboPiece
}

pub fn related_card_component_schema() -> glon.JsonSchema(RelatedCardComponent) {
  glon.enum_map([
    #("token", Token),
    #("meld_part", MeldPart),
    #("meld_result", MeldResult),
    #("combo_piece", ComboPiece),
  ])
}

pub type CardBorderColor {
  Black
  White
  Borderless
  Yellow
  Silver
  Gold
}

pub fn card_border_color_schema() -> glon.JsonSchema(CardBorderColor) {
  glon.enum_map([
    #("black", Black),
    #("white", White),
    #("borderless", Borderless),
    #("yellow", Yellow),
    #("silver", Silver),
    #("gold", Gold),
  ])
}

pub type CardFinish {
  Foil
  NonFoil
  Etched
}

pub fn card_finish_schema() -> glon.JsonSchema(CardFinish) {
  glon.enum_map([
    #("foil", Foil),
    #("nonfoil", NonFoil),
    #("etched", Etched),
  ])
}

pub type CardPrice {
  CardPrice(
    usd: Option(String),
    usd_foil: Option(String),
    usd_etched: Option(String),
    eur: Option(String),
    eur_foil: Option(String),
    eur_etched: Option(String),
    tix: Option(String),
  )
}

pub fn card_price_schema() -> glon.JsonSchema(CardPrice) {
  use usd <- glon.optional_or_null("usd", glon.string())
  use usd_foil <- glon.optional_or_null("usd_foil", glon.string())
  use usd_etched <- glon.optional_or_null("usd_etched", glon.string())
  use eur <- glon.optional_or_null("eur", glon.string())
  use eur_foil <- glon.optional_or_null("eur_foil", glon.string())
  use eur_etched <- glon.optional_or_null("eur_etched", glon.string())
  use tix <- glon.optional_or_null("tix", glon.string())
  glon.success(CardPrice(
    usd:,
    usd_foil:,
    usd_etched:,
    eur:,
    eur_foil:,
    eur_etched:,
    tix:,
  ))
}

/// The purchase links Scryfall provides for a card, keyed by storefront.
pub type PurchaseUris {
  PurchaseUris(
    tcgplayer: Option(Uri),
    cardmarket: Option(Uri),
    cardhoarder: Option(Uri),
  )
}

pub fn purchase_uris_schema() -> glon.JsonSchema(PurchaseUris) {
  use tcgplayer <- glon.optional("tcgplayer", common.uri_schema())
  use cardmarket <- glon.optional("cardmarket", common.uri_schema())
  use cardhoarder <- glon.optional("cardhoarder", common.uri_schema())
  glon.success(PurchaseUris(tcgplayer:, cardmarket:, cardhoarder:))
}

/// Third-party resource links related to a card, keyed by site.
pub type RelatedUris {
  RelatedUris(
    gatherer: Option(Uri),
    tcgplayer_infinite_articles: Option(Uri),
    tcgplayer_infinite_decks: Option(Uri),
    edhrec: Option(Uri),
  )
}

pub fn related_uris_schema() -> glon.JsonSchema(RelatedUris) {
  use gatherer <- glon.optional("gatherer", common.uri_schema())
  use tcgplayer_infinite_articles <- glon.optional(
    "tcgplayer_infinite_articles",
    common.uri_schema(),
  )
  use tcgplayer_infinite_decks <- glon.optional(
    "tcgplayer_infinite_decks",
    common.uri_schema(),
  )
  use edhrec <- glon.optional("edhrec", common.uri_schema())
  glon.success(RelatedUris(
    gatherer:,
    tcgplayer_infinite_articles:,
    tcgplayer_infinite_decks:,
    edhrec:,
  ))
}

pub type CardRarity {
  Common
  Uncommon
  Rare
  Special
  Mythic
  Bonus
}

pub fn card_rarity_schema() -> glon.JsonSchema(CardRarity) {
  glon.enum_map([
    #("common", Common),
    #("uncommon", Uncommon),
    #("rare", Rare),
    #("special", Special),
    #("mythic", Mythic),
    #("bonus", Bonus),
  ])
}

pub type SecurityStamp {
  Oval
  Triangle
  Acorn
  Circle
  Arena
  Heart
}

pub fn security_stamp_schema() -> glon.JsonSchema(SecurityStamp) {
  glon.enum_map([
    #("oval", Oval),
    #("triangle", Triangle),
    #("acorn", Acorn),
    #("circle", Circle),
    #("arena", Arena),
    #("heart", Heart),
  ])
}

pub type CardPreview {
  CardPreview(
    previewed_at: Option(Int),
    source_uri: Option(Uri),
    source: Option(String),
  )
}

pub fn card_preview_schema() -> glon.JsonSchema(CardPreview) {
  use previewed_at <- glon.optional("previewed_at", common.date_schema())
  use source_uri <- glon.optional("source_uri", common.uri_schema())
  use source <- glon.optional("source", glon.string())
  glon.success(CardPreview(previewed_at:, source_uri:, source:))
}
