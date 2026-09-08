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

On top of that, `scruffy/client/*` gives you a pair of plain functions for
every Scryfall endpoint: a `*_request` that builds the `Request(String)` to
send, and a `*_response` that decodes the `Response(String)` you got back
into the object you asked for, or a `scruffy/client.ClientError` describing
what went wrong.

## Installation

```sh
gleam add scruffy@1
```

## Usage

`scruffy` never picks an HTTP client for you. Build a request with a
`*_request` function, send it with whatever HTTP client suits your project,
and decode the response with the matching `*_response` function. On Erlang,
that HTTP client can be [`gleam_httpc`](https://hexdocs.pm/gleam_httpc/)'s
`send`:

```gleam
import gleam/httpc
import gleam/io
import gleam/result
import scruffy/client
import scruffy/client/cards

pub fn main() -> Nil {
  let result = {
    use resp <- result.try(
      cards.get_card_by_id_request("bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd")
      |> httpc.send,
    )
    cards.card_response(resp)
  }

  case result {
    Ok(card) -> io.println(card.name)
    Error(client.ApiError(err)) -> io.println("Scryfall said: " <> err.details)
    Error(_) -> io.println("Something else went wrong")
  }
}
```

The same two functions work with a Promise-based client too (e.g.
[`gleam_fetch`](https://hexdocs.pm/gleam_fetch/) on the JavaScript target)
-- just `await` the response between them:

```gleam
use resp <- promise.try_await(fetch.send(cards.get_card_by_id_request(id)))
use resp <- promise.try_await(fetch.read_text_body(resp))
promise.resolve(cards.card_response(resp))
```

Further documentation can be found at <https://hexdocs.pm/scruffy>.

## Development

```sh
gleam test    # Run the tests. The integration suite (test/scruffy_integration_test.gleam)
              # calls the live Scryfall API via gleam_httpc, so it needs network access and
              # only runs on the Erlang target -- `gleam test --target javascript` skips it.
gleam format  # Format the source
```
