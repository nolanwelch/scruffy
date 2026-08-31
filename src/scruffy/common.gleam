import gleam/int
import gleam/string
import gleam/uri.{type Uri}
import glon

pub type Uuid =
  String

/// A schema for UUID strings, decoded as-is.
pub fn uuid_schema() -> glon.JsonSchema(Uuid) {
  glon.string()
}

/// A schema for URI strings, decoded via `gleam/uri.parse`.
///
/// Scryfall guarantees every URI it returns is well-formed, so a value that
/// fails to parse indicates a breaking change upstream and is treated as a
/// decode-time bug rather than a recoverable error.
pub fn uri_schema() -> glon.JsonSchema(Uri) {
  glon.string()
  |> glon.map(fn(s) {
    let assert Ok(parsed) = uri.parse(s)
    parsed
  })
}

/// A schema for Scryfall's `"YYYY-MM-DD"` date strings, decoded into a Unix
/// timestamp representing midnight UTC on that date.
///
/// Several Scryfall entities (cards, sets, rulings, migrations, preview
/// info) currently model timestamps as `Int` "for now", so this keeps that
/// contract without pulling in a date/time library.
pub fn date_schema() -> glon.JsonSchema(Int) {
  glon.string()
  |> glon.map(fn(s) {
    let assert Ok(seconds) = date_to_unix_seconds(s)
    seconds
  })
}

/// Parses a `"YYYY-MM-DD"` date string into a Unix timestamp in seconds
/// (midnight UTC on that date), using the proleptic Gregorian calendar.
///
/// Only valid for years on or after 1 CE; that covers every date Scryfall
/// has ever returned.
pub fn date_to_unix_seconds(date: String) -> Result(Int, Nil) {
  case string.split(date, "-") {
    [y, m, d] -> {
      case int.parse(y), int.parse(m), int.parse(d) {
        Ok(year), Ok(month), Ok(day) ->
          Ok(days_from_civil(year, month, day) * 86_400)
        _, _, _ -> Error(Nil)
      }
    }
    _ -> Error(Nil)
  }
}

/// Days since the Unix epoch (1970-01-01) for a given proleptic Gregorian
/// calendar date. Based on Howard Hinnant's `days_from_civil` algorithm.
fn days_from_civil(year: Int, month: Int, day: Int) -> Int {
  let y = case month <= 2 {
    True -> year - 1
    False -> year
  }
  let era = y / 400
  let year_of_era = y - era * 400
  let day_of_year =
    {
      153
      * case month > 2 {
        True -> month - 3
        False -> month + 9
      }
      + 2
    }
    / 5
    + day
    - 1
  let day_of_era =
    year_of_era * 365 + year_of_era / 4 - year_of_era / 100 + day_of_year
  era * 146_097 + day_of_era - 719_468
}
