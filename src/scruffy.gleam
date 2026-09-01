//// `scruffy` is a Gleam client for the
//// [Scryfall](https://scryfall.com/docs/api) Magic: The Gathering API.
////
//// The package ships the types modelling Scryfall's objects -- cards,
//// sets, rulings, symbols, and the other resources it exposes -- and a
//// `*_schema()` JSON decoder for each of them, built with
//// [Glon](https://hexdocs.pm/glon/). `scruffy/client/*` builds on top of
//// that with a function per Scryfall endpoint that sends the request and
//// decodes the response for you, via `scruffy/client`.
////
//// Call `new` once with your `client.Requester` to get every one of those
//// functions back, already wired up to it and grouped the way Scryfall
//// groups its own endpoints:
////
//// ```gleam
//// import gleam/httpc
//// import scruffy
////
//// let scryfall = scruffy.new(httpc.send)
//// scryfall.cards.get_card_by_id("bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd")
//// scryfall.catalogs.get_card_names()
//// ```

import scruffy/client.{type Requester}
import scruffy/client/bulk_data
import scruffy/client/cards
import scruffy/client/catalogs
import scruffy/client/migrations

/// Every Scryfall endpoint function, grouped by resource and already wired
/// up to a `Requester` -- see `new`.
pub type Client(e) {
  Client(
    cards: cards.Client(e),
    catalogs: catalogs.Client(e),
    bulk_data: bulk_data.Client(e),
    migrations: migrations.Client(e),
  )
}

/// Build a `Client` bound to the given `Requester`. On Erlang, that's
/// `gleam_httpc`'s `send`, unchanged: `scruffy.new(httpc.send)`.
pub fn new(requester: Requester(e)) -> Client(e) {
  Client(
    cards: cards.new(requester),
    catalogs: catalogs.new(requester),
    bulk_data: bulk_data.new(requester),
    migrations: migrations.new(requester),
  )
}
