import gleam/option.{type Option}
import scruffy/common.{type Uuid}
import scruffy/list.{type ScryfallList}
import scruffy/set.{type Set}

pub fn list_sets() -> ScryfallList(Set) {
  todo
}

pub fn get_set_by_code(code: String) -> Option(Set) {
  todo
}

pub fn get_set_by_tcgplayer_id(id: Int) -> Option(Set) {
  todo
}

pub fn get_set_by_scryfall_id(id: Uuid) -> Option(Set) {
  todo
}
