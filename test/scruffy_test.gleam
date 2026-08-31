import gleam/option
import gleam/uri
import gleeunit
import glon
import scruffy/card
import scruffy/card_symbol
import scruffy/catalog
import scruffy/error
import scruffy/frame
import scruffy/layout
import scruffy/list as scryfall_list
import scruffy/migrations
import scruffy/ruling
import scruffy/set

pub fn main() -> Nil {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  let name = "Joe"
  let greeting = "Hello, " <> name <> "!"

  assert greeting == "Hello, Joe!"
}

// The JSON fixtures below are trimmed, real responses from the live
// Scryfall API (fetched 2026-08-31), used to check the decoders against
// actual API output rather than hand-rolled JSON.

const card_black_lotus_json = "{\"object\":\"card\",\"id\":\"bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd\",\"oracle_id\":\"5089ec1a-f881-4d55-af14-5d996171203b\",\"multiverse_ids\":[382866],\"mtgo_id\":53155,\"mtgo_foil_id\":53156,\"name\":\"Black Lotus\",\"lang\":\"en\",\"released_at\":\"2014-06-16\",\"uri\":\"https://api.scryfall.com/cards/bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd\",\"scryfall_uri\":\"https://scryfall.com/card/vma/4/black-lotus?utm_source=api\",\"layout\":\"normal\",\"highres_image\":true,\"image_status\":\"highres_scan\",\"image_updated_at\":\"2026-07-13T10:42:12Z\",\"image_uris\":{\"small\":\"https://cards.scryfall.io/small/front/b/d/bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd.jpg?1783939332\",\"normal\":\"https://cards.scryfall.io/normal/front/b/d/bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd.jpg?1783939332\",\"large\":\"https://cards.scryfall.io/large/front/b/d/bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd.jpg?1783939332\",\"png\":\"https://cards.scryfall.io/png/front/b/d/bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd.png?1783939332\",\"art_crop\":\"https://cards.scryfall.io/art_crop/front/b/d/bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd.jpg?1783939332\",\"border_crop\":\"https://cards.scryfall.io/border_crop/front/b/d/bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd.jpg?1783939332\",\"thumb\":\"https://cards.scryfall.io/thumb/front/b/d/bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd.webp?1783939332\",\"grid\":\"https://cards.scryfall.io/grid/front/b/d/bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd.webp?1783939332\",\"display\":\"https://cards.scryfall.io/display/front/b/d/bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd.webp?1783939332\",\"art\":\"https://cards.scryfall.io/art/front/b/d/bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd.webp?1783939332\",\"crop\":\"https://cards.scryfall.io/crop/front/b/d/bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd.webp?1783939332\"},\"mana_cost\":\"{0}\",\"cmc\":0.0,\"type_line\":\"Artifact\",\"oracle_text\":\"{T}, Sacrifice this artifact: Add three mana of any one color.\",\"colors\":[],\"color_identity\":[],\"keywords\":[],\"produced_mana\":[\"B\",\"G\",\"R\",\"U\",\"W\"],\"all_parts\":[{\"object\":\"related_card\",\"id\":\"bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd\",\"component\":\"combo_piece\",\"name\":\"Black Lotus\",\"type_line\":\"Artifact\",\"uri\":\"https://api.scryfall.com/cards/bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd\"},{\"object\":\"related_card\",\"id\":\"85f81500-1b1b-47e7-93a1-db5f6de95e87\",\"component\":\"combo_piece\",\"name\":\"Arzakon\",\"type_line\":\"Legendary Planeswalker — Arzakon\",\"uri\":\"https://api.scryfall.com/cards/85f81500-1b1b-47e7-93a1-db5f6de95e87\"}],\"legalities\":{\"standard\":\"not_legal\",\"future\":\"not_legal\",\"historic\":\"not_legal\",\"timeless\":\"not_legal\",\"gladiator\":\"not_legal\",\"pioneer\":\"not_legal\",\"modern\":\"not_legal\",\"legacy\":\"banned\",\"pauper\":\"not_legal\",\"vintage\":\"restricted\",\"penny\":\"not_legal\",\"commander\":\"banned\",\"oathbreaker\":\"banned\",\"standardbrawl\":\"not_legal\",\"brawl\":\"not_legal\",\"competitivebrawl\":\"not_legal\",\"alchemy\":\"not_legal\",\"paupercommander\":\"not_legal\",\"duel\":\"banned\",\"oldschool\":\"not_legal\",\"premodern\":\"not_legal\",\"predh\":\"banned\",\"tlr\":\"banned\"},\"games\":[\"mtgo\"],\"reserved\":true,\"game_changer\":false,\"foil\":true,\"nonfoil\":true,\"finishes\":[\"nonfoil\",\"foil\"],\"oversized\":false,\"promo\":false,\"reprint\":true,\"variation\":false,\"set_id\":\"a944551a-73fa-41cd-9159-e8d0e4674403\",\"set\":\"vma\",\"set_name\":\"Vintage Masters\",\"set_type\":\"masters\",\"set_uri\":\"https://api.scryfall.com/sets/a944551a-73fa-41cd-9159-e8d0e4674403\",\"set_search_uri\":\"https://api.scryfall.com/cards/search?order=set&q=e%3Avma&unique=prints\",\"scryfall_set_uri\":\"https://scryfall.com/sets/vma?utm_source=api\",\"rulings_uri\":\"https://api.scryfall.com/cards/bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd/rulings\",\"prints_search_uri\":\"https://api.scryfall.com/cards/search?order=released&q=oracleid%3A5089ec1a-f881-4d55-af14-5d996171203b&unique=prints\",\"collector_number\":\"4\",\"digital\":true,\"rarity\":\"bonus\",\"card_back_id\":\"0aeebaf5-8c7d-4636-9e82-8c27447861f7\",\"artist\":\"Chris Rahn\",\"artist_ids\":[\"7742047e-0f80-4c0f-a530-d07460165e86\"],\"illustration_id\":\"da62ded1-bedd-44c6-8950-ca56e691a899\",\"border_color\":\"black\",\"frame\":\"2015\",\"security_stamp\":\"oval\",\"full_art\":false,\"textless\":false,\"booster\":true,\"story_spotlight\":false,\"prices\":{\"usd\":null,\"usd_foil\":null,\"usd_etched\":null,\"eur\":null,\"eur_foil\":null,\"tix\":\"46.91\"},\"related_uris\":{\"gatherer\":\"https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=382866&printed=false\",\"tcgplayer_infinite_articles\":\"https://partner.tcgplayer.com/c/4931599/1830156/21018?subId1=api&trafcat=tcgplayer.com%2Fsearch%2Farticles&u=https%3A%2F%2Fwww.tcgplayer.com%2Fsearch%2Farticles%3FproductLineName%3Dmagic%26q%3DBlack%2BLotus\",\"tcgplayer_infinite_decks\":\"https://partner.tcgplayer.com/c/4931599/1830156/21018?subId1=api&trafcat=tcgplayer.com%2Fsearch%2Fdecks&u=https%3A%2F%2Fwww.tcgplayer.com%2Fsearch%2Fdecks%3FproductLineName%3Dmagic%26q%3DBlack%2BLotus\",\"edhrec\":\"https://edhrec.com/route/?cc=Black+Lotus\"},\"purchase_uris\":{\"tcgplayer\":\"https://partner.tcgplayer.com/c/4931599/1830156/21018?subId1=api&u=https%3A%2F%2Fwww.tcgplayer.com%2Fsearch%2Fmagic%2Fproduct%3FproductLineName%3Dmagic%26q%3DBlack%2BLotus%26view%3Dgrid\",\"cardmarket\":\"https://www.cardmarket.com/en/Magic/Products/Search?referrer=scryfall&searchString=Black+Lotus&utm_campaign=card_prices&utm_medium=text&utm_source=scryfall\",\"cardhoarder\":\"https://www.cardhoarder.com/cards/53155?affiliate_id=scryfall&ref=card-profile&utm_campaign=affiliate&utm_medium=card&utm_source=scryfall\"}}"

const card_delver_json = "{\"object\":\"card\",\"id\":\"6904ea20-e504-47da-95a0-08739fdde260\",\"oracle_id\":\"edd531b9-f615-4399-8c8c-1c5e18c4acbf\",\"multiverse_ids\":[685883],\"mtgo_id\":135494,\"tcgplayer_id\":609611,\"cardmarket_id\":804969,\"name\":\"Delver of Secrets // Insectile Aberration\",\"lang\":\"en\",\"released_at\":\"2025-01-24\",\"uri\":\"https://api.scryfall.com/cards/6904ea20-e504-47da-95a0-08739fdde260\",\"scryfall_uri\":\"https://scryfall.com/card/inr/60/delver-of-secrets-insectile-aberration?utm_source=api\",\"layout\":\"transform\",\"highres_image\":true,\"image_status\":\"highres_scan\",\"image_updated_at\":\"2026-07-13T02:02:53Z\",\"cmc\":1.0,\"type_line\":\"Creature — Human Wizard // Creature — Human Insect\",\"color_identity\":[\"U\"],\"keywords\":[\"Flying\",\"Transform\"],\"card_faces\":[{\"object\":\"card_face\",\"name\":\"Delver of Secrets\",\"mana_cost\":\"{U}\",\"type_line\":\"Creature — Human Wizard\",\"oracle_text\":\"At the beginning of your upkeep, look at the top card of your library. You may reveal that card. If an instant or sorcery card is revealed this way, transform this creature.\",\"colors\":[\"U\"],\"power\":\"1\",\"toughness\":\"1\",\"artist\":\"Nils Hamm\",\"artist_id\":\"c540d1fc-1500-457f-93cf-d6069ee66546\",\"illustration_id\":\"1c2fee9b-89ea-4ab1-a751-451c3cd65a88\",\"image_uris\":{\"small\":\"https://cards.scryfall.io/small/front/6/9/6904ea20-e504-47da-95a0-08739fdde260.jpg?1783908173\",\"normal\":\"https://cards.scryfall.io/normal/front/6/9/6904ea20-e504-47da-95a0-08739fdde260.jpg?1783908173\",\"large\":\"https://cards.scryfall.io/large/front/6/9/6904ea20-e504-47da-95a0-08739fdde260.jpg?1783908173\",\"png\":\"https://cards.scryfall.io/png/front/6/9/6904ea20-e504-47da-95a0-08739fdde260.png?1783908173\",\"art_crop\":\"https://cards.scryfall.io/art_crop/front/6/9/6904ea20-e504-47da-95a0-08739fdde260.jpg?1783908173\",\"border_crop\":\"https://cards.scryfall.io/border_crop/front/6/9/6904ea20-e504-47da-95a0-08739fdde260.jpg?1783908173\",\"thumb\":\"https://cards.scryfall.io/thumb/front/6/9/6904ea20-e504-47da-95a0-08739fdde260.webp?1783908173\",\"grid\":\"https://cards.scryfall.io/grid/front/6/9/6904ea20-e504-47da-95a0-08739fdde260.webp?1783908173\",\"display\":\"https://cards.scryfall.io/display/front/6/9/6904ea20-e504-47da-95a0-08739fdde260.webp?1783908173\",\"art\":\"https://cards.scryfall.io/art/front/6/9/6904ea20-e504-47da-95a0-08739fdde260.webp?1783908173\",\"crop\":\"https://cards.scryfall.io/crop/front/6/9/6904ea20-e504-47da-95a0-08739fdde260.webp?1783908173\"}},{\"object\":\"card_face\",\"name\":\"Insectile Aberration\",\"mana_cost\":\"\",\"type_line\":\"Creature — Human Insect\",\"oracle_text\":\"Flying\",\"colors\":[\"U\"],\"color_indicator\":[\"U\"],\"power\":\"3\",\"toughness\":\"2\",\"flavor_text\":\"\\\"Unfortunately, all my test animals have died or escaped, so I shall be the final subject. I feel no fear. This is a momentous night.\\\"\\n—Laboratory notes, final entry\",\"artist\":\"Nils Hamm\",\"artist_id\":\"c540d1fc-1500-457f-93cf-d6069ee66546\",\"illustration_id\":\"c2b5f731-771b-4949-90f3-0ad40d676100\",\"image_uris\":{\"small\":\"https://cards.scryfall.io/small/back/6/9/6904ea20-e504-47da-95a0-08739fdde260.jpg?1783908173\",\"normal\":\"https://cards.scryfall.io/normal/back/6/9/6904ea20-e504-47da-95a0-08739fdde260.jpg?1783908173\",\"large\":\"https://cards.scryfall.io/large/back/6/9/6904ea20-e504-47da-95a0-08739fdde260.jpg?1783908173\",\"png\":\"https://cards.scryfall.io/png/back/6/9/6904ea20-e504-47da-95a0-08739fdde260.png?1783908173\",\"art_crop\":\"https://cards.scryfall.io/art_crop/back/6/9/6904ea20-e504-47da-95a0-08739fdde260.jpg?1783908173\",\"border_crop\":\"https://cards.scryfall.io/border_crop/back/6/9/6904ea20-e504-47da-95a0-08739fdde260.jpg?1783908173\",\"thumb\":\"https://cards.scryfall.io/thumb/back/6/9/6904ea20-e504-47da-95a0-08739fdde260.webp?1783908173\",\"grid\":\"https://cards.scryfall.io/grid/back/6/9/6904ea20-e504-47da-95a0-08739fdde260.webp?1783908173\",\"display\":\"https://cards.scryfall.io/display/back/6/9/6904ea20-e504-47da-95a0-08739fdde260.webp?1783908173\",\"art\":\"https://cards.scryfall.io/art/back/6/9/6904ea20-e504-47da-95a0-08739fdde260.webp?1783908173\",\"crop\":\"https://cards.scryfall.io/crop/back/6/9/6904ea20-e504-47da-95a0-08739fdde260.webp?1783908173\"}}],\"all_parts\":[{\"object\":\"related_card\",\"id\":\"99ce1bee-8f95-4284-8e06-9de9bfcb53b5\",\"component\":\"combo_piece\",\"name\":\"Innistrad Checklist\",\"type_line\":\"Card\",\"uri\":\"https://api.scryfall.com/cards/99ce1bee-8f95-4284-8e06-9de9bfcb53b5\"},{\"object\":\"related_card\",\"id\":\"871c4ccc-5a14-4583-b4c7-6f2d2aeb8253\",\"component\":\"combo_piece\",\"name\":\"Delver of Secrets // Insectile Aberration\",\"type_line\":\"Creature — Human Wizard // Creature — Human Insect\",\"uri\":\"https://api.scryfall.com/cards/871c4ccc-5a14-4583-b4c7-6f2d2aeb8253\"}],\"legalities\":{\"standard\":\"not_legal\",\"future\":\"not_legal\",\"historic\":\"legal\",\"timeless\":\"legal\",\"gladiator\":\"legal\",\"pioneer\":\"legal\",\"modern\":\"legal\",\"legacy\":\"legal\",\"pauper\":\"legal\",\"vintage\":\"legal\",\"penny\":\"not_legal\",\"commander\":\"legal\",\"oathbreaker\":\"legal\",\"standardbrawl\":\"not_legal\",\"brawl\":\"legal\",\"competitivebrawl\":\"legal\",\"alchemy\":\"not_legal\",\"paupercommander\":\"legal\",\"duel\":\"legal\",\"oldschool\":\"not_legal\",\"premodern\":\"not_legal\",\"predh\":\"not_legal\",\"tlr\":\"legal\"},\"games\":[\"paper\",\"mtgo\"],\"reserved\":false,\"game_changer\":false,\"foil\":true,\"nonfoil\":true,\"finishes\":[\"nonfoil\",\"foil\"],\"oversized\":false,\"promo\":false,\"reprint\":true,\"variation\":false,\"set_id\":\"b9618c8c-9f31-4b42-9798-2991893c27bf\",\"set\":\"inr\",\"set_name\":\"Innistrad Remastered\",\"set_type\":\"masters\",\"set_uri\":\"https://api.scryfall.com/sets/b9618c8c-9f31-4b42-9798-2991893c27bf\",\"set_search_uri\":\"https://api.scryfall.com/cards/search?order=set&q=e%3Ainr&unique=prints\",\"scryfall_set_uri\":\"https://scryfall.com/sets/inr?utm_source=api\",\"rulings_uri\":\"https://api.scryfall.com/cards/6904ea20-e504-47da-95a0-08739fdde260/rulings\",\"prints_search_uri\":\"https://api.scryfall.com/cards/search?order=released&q=oracleid%3Aedd531b9-f615-4399-8c8c-1c5e18c4acbf&unique=prints\",\"collector_number\":\"60\",\"digital\":false,\"rarity\":\"common\",\"artist\":\"Nils Hamm\",\"artist_ids\":[\"c540d1fc-1500-457f-93cf-d6069ee66546\"],\"border_color\":\"black\",\"frame\":\"2015\",\"full_art\":false,\"textless\":false,\"booster\":true,\"story_spotlight\":false,\"edhrec_rank\":16015,\"penny_rank\":184,\"preview\":{\"source\":\"Wizards of the Coast\",\"source_uri\":\"\",\"previewed_at\":\"2025-01-07\"},\"prices\":{\"usd\":\"0.29\",\"usd_foil\":\"0.43\",\"usd_etched\":null,\"eur\":\"0.39\",\"eur_foil\":\"0.57\",\"tix\":\"0.04\"},\"related_uris\":{\"gatherer\":\"https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=685883&printed=false\",\"tcgplayer_infinite_articles\":\"https://partner.tcgplayer.com/c/4931599/1830156/21018?subId1=api&trafcat=tcgplayer.com%2Fsearch%2Farticles&u=https%3A%2F%2Fwww.tcgplayer.com%2Fsearch%2Farticles%3FproductLineName%3Dmagic%26q%3DDelver%2Bof%2BSecrets%2B%252F%252F%2BInsectile%2BAberration\",\"tcgplayer_infinite_decks\":\"https://partner.tcgplayer.com/c/4931599/1830156/21018?subId1=api&trafcat=tcgplayer.com%2Fsearch%2Fdecks&u=https%3A%2F%2Fwww.tcgplayer.com%2Fsearch%2Fdecks%3FproductLineName%3Dmagic%26q%3DDelver%2Bof%2BSecrets%2B%252F%252F%2BInsectile%2BAberration\",\"edhrec\":\"https://edhrec.com/route/?cc=Delver+of+Secrets\"},\"purchase_uris\":{\"tcgplayer\":\"https://partner.tcgplayer.com/c/4931599/1830156/21018?subId1=api&u=https%3A%2F%2Fwww.tcgplayer.com%2Fproduct%2F609611%3Fpage%3D1\",\"cardmarket\":\"https://www.cardmarket.com/en/Magic/Products?idProduct=804969&referrer=scryfall&utm_campaign=card_prices&utm_medium=text&utm_source=scryfall\",\"cardhoarder\":\"https://www.cardhoarder.com/cards/135494?affiliate_id=scryfall&ref=card-profile&utm_campaign=affiliate&utm_medium=card&utm_source=scryfall\"}}"

const set_vma_json = "{\"object\":\"set\",\"id\":\"a944551a-73fa-41cd-9159-e8d0e4674403\",\"code\":\"vma\",\"mtgo_code\":\"vma\",\"arena_code\":\"vma\",\"name\":\"Vintage Masters\",\"uri\":\"https://api.scryfall.com/sets/a944551a-73fa-41cd-9159-e8d0e4674403\",\"scryfall_uri\":\"https://scryfall.com/sets/vma\",\"search_uri\":\"https://api.scryfall.com/cards/search?include_extras=true&include_variations=true&order=set&q=e%3Avma&unique=prints\",\"released_at\":\"2014-06-16\",\"set_type\":\"masters\",\"card_count\":325,\"printed_size\":325,\"digital\":true,\"nonfoil_only\":false,\"foil_only\":false,\"icon_svg_uri\":\"https://svgs.scryfall.io/sets/vma.svg?1788148800\"}"

const catalog_json = "{\"object\": \"catalog\", \"uri\": \"https://api.scryfall.com/catalog/card-names\", \"total_values\": 35070, \"data\": [\"\\\"Ach! Hans, Run!\\\"\", \"\\\"Brims\\\" Barone, Midway Mobster\", \"\\\"Lifetime\\\" Pass Holder\"]}"

const migrations_json = "{\"object\": \"list\", \"has_more\": true, \"next_page\": \"https://api.scryfall.com/migrations?page=2\", \"data\": [{\"object\": \"migration\", \"id\": \"c1f42400-9376-429c-80de-eda1e58b4936\", \"uri\": \"https://api.scryfall.com/migrations/c1f42400-9376-429c-80de-eda1e58b4936\", \"performed_at\": \"2026-08-19\", \"migration_strategy\": \"delete\", \"old_scryfall_id\": \"fb3f52eb-9027-4201-998c-807d52abe7be\", \"note\": \"Not collectable on MTGO\", \"metadata\": {\"id\": \"fb3f52eb-9027-4201-998c-807d52abe7be\", \"lang\": \"en\", \"name\": \"Lovisa Coldeyes\", \"set_code\": \"pz2\", \"oracle_id\": \"720879dc-7593-41c0-ab3d-936069f26930\", \"collector_number\": \"65849\"}}, {\"object\": \"migration\", \"id\": \"fc5c189f-1787-480e-8ae0-2c3ebdd40af1\", \"uri\": \"https://api.scryfall.com/migrations/fc5c189f-1787-480e-8ae0-2c3ebdd40af1\", \"performed_at\": \"2026-08-19\", \"migration_strategy\": \"delete\", \"old_scryfall_id\": \"f42f5188-6e8b-492f-8357-e1d1c654c58b\", \"note\": \"Not collectable on MTGO\", \"metadata\": {\"id\": \"f42f5188-6e8b-492f-8357-e1d1c654c58b\", \"lang\": \"en\", \"name\": \"Aquitect's Will\", \"set_code\": \"pz2\", \"oracle_id\": \"d02befcb-3e2c-4cfe-a913-9bb648e5bb2c\", \"collector_number\": \"65865\"}}]}"

const symbology_json = "[{\"object\": \"card_symbol\", \"symbol\": \"{T}\", \"svg_uri\": \"https://svgs.scryfall.io/card-symbols/T.svg\", \"loose_variant\": null, \"english\": \"tap this permanent\", \"transposable\": false, \"represents_mana\": false, \"appears_in_mana_costs\": false, \"mana_value\": 0.0, \"hybrid\": false, \"phyrexian\": false, \"cmc\": 0.0, \"funny\": false, \"colors\": [], \"gatherer_alternates\": [\"ocT\", \"oT\"]}, {\"object\": \"card_symbol\", \"symbol\": \"{Q}\", \"svg_uri\": \"https://svgs.scryfall.io/card-symbols/Q.svg\", \"loose_variant\": null, \"english\": \"untap this permanent\", \"transposable\": false, \"represents_mana\": false, \"appears_in_mana_costs\": false, \"mana_value\": 0.0, \"hybrid\": false, \"phyrexian\": false, \"cmc\": 0.0, \"funny\": false, \"colors\": [], \"gatherer_alternates\": null}, {\"object\": \"card_symbol\", \"symbol\": \"{E}\", \"svg_uri\": \"https://svgs.scryfall.io/card-symbols/E.svg\", \"loose_variant\": null, \"english\": \"an energy counter\", \"transposable\": false, \"represents_mana\": false, \"appears_in_mana_costs\": false, \"mana_value\": 0.0, \"hybrid\": false, \"phyrexian\": false, \"cmc\": 0.0, \"funny\": false, \"colors\": [], \"gatherer_alternates\": null}]"

const scryfall_error_json = "{
  \"object\": \"error\",
  \"code\": \"not_found\",
  \"status\": 404,
  \"details\": \"The requested object or REST method was not found.\"
}"

const ruling_json = "{\"object\":\"ruling\",\"oracle_id\":\"5089ec1a-f881-4d55-af14-5d996171203b\",\"source\":\"wotc\",\"published_at\":\"2019-01-25\",\"comment\":\"Some card gains no benefit from its own static ability.\"}"

pub fn decode_card_single_faced_test() {
  let assert Ok(c) =
    glon.decode(card.card_schema(), from: card_black_lotus_json)

  assert c.name == "Black Lotus"
  assert c.mana_cost == option.Some("{0}")
  assert c.reserved == True
  assert c.rarity == card.Bonus
  assert c.border_color == card.Black
  assert c.frame == frame.Y2015
  assert c.security_stamp == option.Some(card.Oval)
  assert c.card_back_id == option.Some("0aeebaf5-8c7d-4636-9e82-8c27447861f7")

  // legalities is decoded from Scryfall's per-format object, not a list.
  assert c.legalities.vintage == card.Restricted
  assert c.legalities.legacy == card.Banned
  assert c.legalities.standard == card.NotLegal

  // prices distinguishes an explicit JSON `null` (usd) from a key that is
  // entirely absent (eur_etched) -- both decode to `None`.
  assert c.prices.usd == option.None
  assert c.prices.eur_etched == option.None
  assert c.prices.tix == option.Some("46.91")

  // image_uris/related_uris/purchase_uris are decoded from Scryfall's
  // keyed objects, not lists.
  let assert option.Some(image_uris) = c.image_uris
  assert image_uris.normal
    == option.Some(parse_uri(
      "https://cards.scryfall.io/normal/front/b/d/bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd.jpg?1783939332",
    ))
  assert c.related_uris.gatherer != option.None
  let assert option.Some(purchase_uris) = c.purchase_uris
  assert purchase_uris.tcgplayer != option.None

  // released_at is parsed from a "YYYY-MM-DD" string into Unix seconds.
  assert c.released_at == 1_402_876_800
}

pub fn decode_card_double_faced_test() {
  let assert Ok(c) = glon.decode(card.card_schema(), from: card_delver_json)

  assert c.name == "Delver of Secrets // Insectile Aberration"
  assert c.layout == layout.Transform
  assert c.image_uris == option.None
  // Absent on this real transform-card response.
  assert c.card_back_id == option.None

  let assert option.Some(faces) = c.card_faces
  assert list_length(faces) == 2

  let assert Ok(front) = first(faces)
  assert front.name == "Delver of Secrets"
  let assert option.Some(front_images) = front.image_uris
  assert front_images.small != option.None
}

pub fn decode_set_test() {
  let assert Ok(s) = glon.decode(set.set_schema(), from: set_vma_json)

  assert s.code == "vma"
  assert s.name == "Vintage Masters"
  assert s.set_type == set.Masters
  assert s.released_at == option.Some(1_402_876_800)
  assert s.digital == True
}

pub fn decode_scryfall_error_test() {
  let assert Ok(e) =
    glon.decode(error.scryfall_error_schema(), from: scryfall_error_json)

  assert e.status == 404
  assert e.code == "not_found"
}

pub fn decode_ruling_test() {
  let assert Ok(r) = glon.decode(ruling.ruling_schema(), from: ruling_json)

  assert r.source == ruling.Wotc
  assert r.published_at == 1_548_374_400
}

pub fn decode_catalog_test() {
  let assert Ok(cat) =
    glon.decode(catalog.catalog_schema(of: glon.string()), from: catalog_json)

  assert cat.total_values == 35_070
  assert list_length(cat.data) == 3
}

pub fn decode_migrations_test() {
  let assert Ok(migration_list) =
    glon.decode(
      scryfall_list.scryfall_list_schema(of: migrations.card_migration_schema()),
      from: migrations_json,
    )

  assert list_length(migration_list.data) == 2
  let assert Ok(first_migration) = first(migration_list.data)
  assert first_migration.migration_strategy == migrations.Delete
  // performed_at, like other Scryfall timestamps, is a "YYYY-MM-DD" string.
  assert first_migration.performed_at == 1_787_097_600
  let assert option.Some(metadata) = first_migration.metadata
  // The JSON key is `lang`, mapped onto the `language` field.
  assert metadata.language == option.Some("en")
}

pub fn decode_symbology_test() {
  let assert Ok(symbols) =
    glon.decode(
      glon.array(of: card_symbol.card_symbol_schema()),
      from: symbology_json,
    )

  assert list_length(symbols) == 3
  let assert Ok(tap_symbol) = first(symbols)
  assert tap_symbol.symbol == "{T}"
  assert tap_symbol.represents_mana == False
}

pub fn decode_scryfall_list_test() {
  let json_str =
    "{\"data\":[\"a\",\"b\"],\"has_more\":false,\"next_page\":null,\"total_cards\":2,\"warnings\":null}"
  let assert Ok(l) =
    glon.decode(
      scryfall_list.scryfall_list_schema(of: glon.string()),
      from: json_str,
    )

  assert l.data == ["a", "b"]
  assert l.has_more == False
  assert l.total_cards == option.Some(2)
}

fn list_length(l: List(a)) -> Int {
  case l {
    [] -> 0
    [_, ..rest] -> 1 + list_length(rest)
  }
}

fn first(l: List(a)) -> Result(a, Nil) {
  case l {
    [] -> Error(Nil)
    [x, ..] -> Ok(x)
  }
}

fn parse_uri(s: String) -> uri.Uri {
  let assert Ok(u) = uri.parse(s)
  u
}
