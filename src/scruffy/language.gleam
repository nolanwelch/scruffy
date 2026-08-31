//// A type describing the languages Magic cards have been printed in.

import glon

/// A language a card has been printed in.
pub type Language {
  English
  Spanish
  French
  German
  Italian
  Portuguese
  Japanese
  Korean
  Russian
  SimplifiedChinese
  TraditionalChinese
  Hebrew
  Latin
  AncientGreek
  Arabic
  Sanskrit
  Phyrexian
  Quenya
  Dwarvish
}

pub fn language_schema() -> glon.JsonSchema(Language) {
  glon.enum_map([
    #("en", English),
    #("es", Spanish),
    #("fr", French),
    #("de", German),
    #("it", Italian),
    #("pt", Portuguese),
    #("ja", Japanese),
    #("ko", Korean),
    #("ru", Russian),
    #("zhs", SimplifiedChinese),
    #("zht", TraditionalChinese),
    #("he", Hebrew),
    #("la", Latin),
    #("grc", AncientGreek),
    #("ar", Arabic),
    #("sa", Sanskrit),
    #("ph", Phyrexian),
    #("qya", Quenya),
    #("dw", Dwarvish),
  ])
}
