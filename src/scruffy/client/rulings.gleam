import gleam/option.{type Option}
import scruffy/common.{type Uuid}
import scruffy/list.{type ScryfallList}
import scruffy/ruling.{type Ruling}

pub type CardIdentifier {
  MultiverseId(id: Int)
  MtgOnlineId(id: Int)
  MtgArenaId(id: Int)
  ScryfallId(id: Uuid)
  SetCodeCollectorNumber(code: String, number: String)
}

pub fn get_rulings_for_card(
  id: CardIdentifier,
  pretty: Option(Bool),
) -> ScryfallList(Ruling) {
  todo
}
