//// Types describing a card's frame — the version of Magic's card layout it
//// was printed with, and any special visual effects applied to it.

/// The version of the card frame a printing uses.
pub type Frame {
  Y1993
  Y1997
  Y2003
  Y2015
  Future
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
