//// Types describing a card's frame — the version of Magic's card layout it
//// was printed with, and any special visual effects applied to it.

import glon

/// The version of the card frame a printing uses.
pub type Frame {
  Y1993
  Y1997
  Y2003
  Y2015
  Future
}

pub fn frame_schema() -> glon.JsonSchema(Frame) {
  glon.enum_map([
    #("1993", Y1993),
    #("1997", Y1997),
    #("2003", Y2003),
    #("2015", Y2015),
    #("future", Future),
  ])
}

/// A special visual effect applied to a card's frame.
pub type FrameEffect {
  Legendary
  Miracle
  Enchantment
  Draft
  Devoid
  Tombstone
  Colorshifted
  Inverted
  DualFaced(subtype: DualFacedFrameEffect)
  Showcase
  ExtendedArt
  Companion
  Etched
  Snow
  Lesson
  ShatteredGlass
  Spree
}

pub fn frame_effect_schema() -> glon.JsonSchema(FrameEffect) {
  glon.enum_map([
    #("legendary", Legendary),
    #("miracle", Miracle),
    #("enchantment", Enchantment),
    #("draft", Draft),
    #("devoid", Devoid),
    #("tombstone", Tombstone),
    #("colorshifted", Colorshifted),
    #("inverted", Inverted),
    #("sunmoondfc", DualFaced(SunMoon)),
    #("compasslanddfc", DualFaced(CompassLand)),
    #("originpwdfc", DualFaced(OriginPlaneswalker)),
    #("mooneldrazidfc", DualFaced(MoonEldrazi)),
    #("waxingandwaningmoondfc", DualFaced(WaxingAndWaningMoon)),
    #("convertdfc", DualFaced(Convert)),
    #("fandfc", DualFaced(Fan)),
    #("upsidedowndfc", DualFaced(UpsideDown)),
    #("showcase", Showcase),
    #("extendedart", ExtendedArt),
    #("companion", Companion),
    #("etched", Etched),
    #("snow", Snow),
    #("lesson", Lesson),
    #("shatteredglass", ShatteredGlass),
    #("spree", Spree),
  ])
}

/// The specific two-sided frame effect used by a `DualFaced` card.
pub type DualFacedFrameEffect {
  SunMoon
  CompassLand
  OriginPlaneswalker
  MoonEldrazi
  WaxingAndWaningMoon
  Convert
  Fan
  UpsideDown
}
