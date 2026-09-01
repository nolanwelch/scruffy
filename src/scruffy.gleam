//// `scruffy` is a Gleam client for the
//// [Scryfall](https://scryfall.com/docs/api) Magic: The Gathering API.
////
//// The package ships the types modelling Scryfall's objects -- cards,
//// sets, rulings, symbols, and the other resources it exposes -- and a
//// `*_schema()` JSON decoder for each of them, built with
//// [Glon](https://hexdocs.pm/glon/). `scruffy/client/*` builds on top of
//// that with a function per Scryfall endpoint that sends the request and
//// decodes the response for you, via `scruffy/client`.

