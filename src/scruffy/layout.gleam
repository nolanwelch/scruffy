//// A type describing the physical layouts a card can be printed in.

import glon

/// The physical layout of a card, such as `Split` or `Transform`.
pub type Layout {
  Normal
  Split
  Flip
  Transform
  ModalDoubleFacedCard
  Meld
  Leveler
  Class
  Case
  Saga
  Adventure
  Prepare
  Mutate
  Prototype
  Battle
  Planar
  Scheme
  Vanguard
  Token
  DoubleFacedToken
  Emblem
  Augment
  Host
  ArtSeries
  ReversibleCard
}

pub fn layout_schema() -> glon.JsonSchema(Layout) {
  glon.enum_map([
    #("normal", Normal),
    #("split", Split),
    #("flip", Flip),
    #("transform", Transform),
    #("modal_dfc", ModalDoubleFacedCard),
    #("meld", Meld),
    #("leveler", Leveler),
    #("class", Class),
    #("case", Case),
    #("saga", Saga),
    #("adventure", Adventure),
    #("prepare", Prepare),
    #("mutate", Mutate),
    #("prototype", Prototype),
    #("battle", Battle),
    #("planar", Planar),
    #("scheme", Scheme),
    #("vanguard", Vanguard),
    #("token", Token),
    #("double_faced_token", DoubleFacedToken),
    #("emblem", Emblem),
    #("augment", Augment),
    #("host", Host),
    #("art_series", ArtSeries),
    #("reversible_card", ReversibleCard),
  ])
}
