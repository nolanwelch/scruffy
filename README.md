# scruffy

[![Package Version](https://img.shields.io/hexpm/v/scruffy)](https://hex.pm/packages/scruffy)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/scruffy/)

A Gleam client for the [Scryfall](https://scryfall.com/docs/api) Magic: The
Gathering API.

## Status

`scruffy` provides Gleam types for the objects the Scryfall API returns
(cards, sets, rulings, symbols, and more) under `scruffy/*`, along with a
[Glon](https://hexdocs.pm/glon/) `*_schema()` decoder for each one -- e.g.
`card.card_schema()` turns a card JSON string into a `Card` via
`glon.decode(card.card_schema(), from: json)`.

On top of that, `scruffy/client/*` gives you a function for every Scryfall
endpoint that builds the request, sends it, and decodes the response for
you -- call one and get back the object you asked for, or a
`scruffy/client.ClientError` describing what went wrong.

## Installation

```sh
gleam add scruffy@1
```

## Usage

```gleam
import gleam/io
import scruffy/client
import scruffy/client/cards

pub fn main() -> Nil {
  case cards.get_card_by_id("bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd") {
    Ok(card) -> io.println(card.name)
    Error(client.ApiError(err)) -> io.println("Scryfall said: " <> err.details)
    Error(_) -> io.println("Something else went wrong")
  }
}
```

`scruffy/client` sends requests with
[`gleam_httpc`](https://hexdocs.pm/gleam_httpc/), Gleam's binding to
Erlang's built-in HTTP client, so `scruffy` targets Erlang. If you'd rather
send requests some other way, build one with `scruffy/client/request` and
decode the response body yourself with the matching `*_schema()` from
`scruffy/*`.

Further documentation can be found at <https://hexdocs.pm/scruffy>.

## Development

```sh
gleam test    # Run the tests, including integration tests that call the
              # live Scryfall API -- you'll need network access
gleam format  # Format the source
```
