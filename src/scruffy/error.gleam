import gleam/option.{type Option}

pub type ScryfallError {
  ScryfallError(
    status: Int,
    code: String,
    details: String,
    error_type: Option(String),
    warnings: Option(List(String)),
  )
}
