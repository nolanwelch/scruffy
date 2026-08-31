# scruffy

[![Package Version](https://img.shields.io/hexpm/v/scruffy)](https://hex.pm/packages/scruffy)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/scruffy/)

A Gleam client for the [Scryfall](https://scryfall.com/docs/api) Magic: The
Gathering API.

## Status

`scruffy` is under early development. So far it provides Gleam types for
the objects the Scryfall API returns (cards, sets, rulings, symbols, and
more) under `scruffy/*`. Request functions and JSON decoders for calling
the API and turning its responses into these types are still to come.

## Installation

```sh
gleam add scruffy@1
```

## Usage

```gleam
import scruffy

pub fn main() -> Nil {
  // TODO: An example of the client in use
}
```

Further documentation can be found at <https://hexdocs.pm/scruffy>.

## Development

```sh
gleam test    # Run the tests
gleam format  # Format the source
```
