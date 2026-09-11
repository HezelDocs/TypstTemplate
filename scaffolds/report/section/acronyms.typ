// -------------------------------------------------------------------
// Copyright © 2026 Dimitri Julmy
// License MIT
// -------------------------------------------------------------------
// Report Template - acronyms.typ
// -------------------------------------------------------------------

// ---------- List of acronyms used in the report — add/remove rows as needed

#let acronyms = (
  ("TODO", "TODO"),
)

#show table.cell.where(x: 0): strong

#table(
  columns: (20%, 80%),
  stroke: none,
  inset: 6pt,
  align: left,
  ..acronyms.flatten()
)
