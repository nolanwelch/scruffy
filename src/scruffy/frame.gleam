pub type Frame {
  Y1993
  Y1997
  Y2003
  Y2015
  Future
}

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
