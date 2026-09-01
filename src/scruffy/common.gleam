//// Small types shared across several Scryfall object types.

import gleam/int
import gleam/result
import gleam/string
import gleam/uri.{type Uri}
import glon

/// A UUID, as used for Scryfall's various object IDs.
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

/// A schema for RFC 3339 datetime strings such as
/// `"2026-08-31T21:01:56.902+00:00"` (or with a trailing `"Z"`), decoded
/// into a Unix timestamp in seconds. Fractional seconds are truncated.
///
/// Scryfall's Bulk Data objects currently model `updated_at` this way "for
/// now", matching the `Int`-timestamp treatment `date_schema` gives plain
/// dates elsewhere in the API.
pub fn datetime_schema() -> glon.JsonSchema(Int) {
  glon.string()
  |> glon.map(fn(s) {
    let assert Ok(seconds) = datetime_to_unix_seconds(s)
    seconds
  })
}

/// Parses an RFC 3339 datetime string into a Unix timestamp in seconds.
pub fn datetime_to_unix_seconds(datetime: String) -> Result(Int, Nil) {
  use #(date_part, time_part) <- result.try(string.split_once(datetime, "T"))
  use day_seconds <- result.try(date_to_unix_seconds(date_part))
  let #(time_of_day, offset) = split_time_and_offset(time_part)
  use time_seconds <- result.try(parse_time_of_day(time_of_day))
  use offset_seconds <- result.try(parse_offset(offset))
  Ok(day_seconds + time_seconds - offset_seconds)
}

/// Splits an RFC 3339 time into its time-of-day and UTC offset, e.g.
/// `"21:01:56.902+00:00"` into `#("21:01:56.902", "+00:00")`. A trailing
/// `"Z"` is treated as a `"+00:00"` offset.
fn split_time_and_offset(time_part: String) -> #(String, String) {
  case string.split_once(time_part, "Z") {
    Ok(#(time_of_day, "")) -> #(time_of_day, "+00:00")
    _ ->
      case string.split_once(time_part, "+") {
        Ok(#(time_of_day, offset)) -> #(time_of_day, "+" <> offset)
        Error(Nil) ->
          case string.split_once(time_part, "-") {
            Ok(#(time_of_day, offset)) -> #(time_of_day, "-" <> offset)
            Error(Nil) -> #(time_part, "+00:00")
          }
      }
  }
}

/// Parses a `"HH:MM:SS"` or `"HH:MM:SS.fff"` time-of-day into the number of
/// seconds since midnight, discarding any fractional part.
fn parse_time_of_day(time_of_day: String) -> Result(Int, Nil) {
  let whole_seconds = case string.split_once(time_of_day, ".") {
    Ok(#(whole, _fraction)) -> whole
    Error(Nil) -> time_of_day
  }

  case string.split(whole_seconds, ":") {
    [h, m, s] -> {
      use hours <- result.try(int.parse(h))
      use minutes <- result.try(int.parse(m))
      use seconds <- result.try(int.parse(s))
      Ok(hours * 3600 + minutes * 60 + seconds)
    }
    _ -> Error(Nil)
  }
}

/// Parses a `"+HH:MM"` or `"-HH:MM"` UTC offset into a (possibly negative)
/// number of seconds.
fn parse_offset(offset: String) -> Result(Int, Nil) {
  use #(sign, rest) <- result.try(string.pop_grapheme(offset))
  use #(hours_str, minutes_str) <- result.try(string.split_once(rest, ":"))
  use hours <- result.try(int.parse(hours_str))
  use minutes <- result.try(int.parse(minutes_str))
  let total_seconds = hours * 3600 + minutes * 60

  case sign {
    "+" -> Ok(total_seconds)
    "-" -> Ok(-total_seconds)
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
