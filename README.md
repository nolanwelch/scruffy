# scruffy

[![Package Version](https://img.shields.io/hexpm/v/scruffy)](https://hex.pm/packages/scruffy)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/scruffy/)

A Gleam client for the [Scryfall](https://scryfall.com/docs/api) Magic: The
Gathering API. Runs on both of Gleam's targets, Erlang and JavaScript.

## Status

`scruffy` provides Gleam types for the objects the Scryfall API returns
(cards, sets, rulings, symbols, and more) under `scruffy/*`, along with a
[Glon](https://hexdocs.pm/glon/) `*_schema()` decoder for each one -- e.g.
`card.card_schema()` turns a card JSON string into a `Card` via
`glon.decode(card.card_schema(), from: json)`.

On top of that, `scruffy/client/*` gives you a function for every Scryfall
endpoint that builds the request and decodes the response for you -- pass
it your HTTP client and get back the object you asked for, or a
`scruffy/client.ClientError` describing what went wrong.

## Installation

```sh
gleam add scruffy@1
```

## Usage

`scruffy` never picks an HTTP client for you -- that's what keeps it usable
from both targets. Instead, call `new` once with a `Requester` -- a plain
`fn(Request(String)) -> Result(Response(String), e)` -- and get back every
endpoint function already wired up to it, grouped the way Scryfall groups
its own endpoints. On Erlang, a `Requester` is
[`gleam_httpc`](https://hexdocs.pm/gleam_httpc/)'s `send`, unchanged:

```gleam
import gleam/httpc
import gleam/io
import scruffy
import scruffy/client

pub fn main() -> Nil {
  let scryfall = scruffy.new(httpc.send)

  case scryfall.cards.get_card_by_id("bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd") {
    Ok(card) -> io.println(card.name)
    Error(client.ApiError(err)) -> io.println("Scryfall said: " <> err.details)
    Error(_) -> io.println("Something else went wrong")
  }
}
```

Prefer a one-off call over building a `Client`? Every function backing it
is also exported directly from its `scruffy/client/*` module, taking the
`Requester` as its first argument: `cards.get_card_by_id(httpc.send, id)`
does the same thing as `scryfall.cards.get_card_by_id(id)` above.

A `Requester` has to return its response synchronously, which rules out
Promise-based clients such as
[`gleam_fetch`](https://hexdocs.pm/gleam_fetch/) on the JavaScript target.
There, skip `scruffy`/`scruffy/client/*` and their `send`: build the
request with `scruffy/client/request`, `await` your own client's response,
and decode its body with the matching `*_schema()` from `scruffy/*` and
`glon.decode`.

Further documentation can be found at <https://hexdocs.pm/scruffy>.

## Development

```sh
gleam test    # Run the tests. The integration suite (test/scruffy_integration_test.gleam)
              # calls the live Scryfall API via gleam_httpc, so it needs network access and
              # only runs on the Erlang target -- `gleam test --target javascript` skips it.
gleam format  # Format the source
```
