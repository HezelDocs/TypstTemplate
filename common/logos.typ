#let max-logos = 5

// Lays out up to `max-logos` institution/partner logos on a single row,
// each getting an equal share of the width (2 logos -> 50% each, 3 -> 33%,
// 4 -> 25%, 5 -> 20%).
//
// Takes a list of already-built image *content* (e.g. `image("...", width:
// 100%)`), built by the caller — NOT raw paths. Typst resolves relative
// paths against the file that contains the `image(...)` call, so calling
// `image()` here (inside the installed package) would resolve paths
// against the package's own directory instead of the consuming project's.
// Each caller must build its images itself, with `width: 100%` so they
// stretch to fill their grid cell.
#let logo-row(logos, gutter: 1cm) = {
  assert(
    logos.len() <= max-logos,
    message: "logo-row supports at most "
      + str(max-logos)
      + " logos, got "
      + str(logos.len()),
  )
  if logos.len() == 0 { return }
  grid(
    columns: (1fr,) * logos.len(),
    column-gutter: gutter,
    align: horizon + center,
    ..logos,
  )
}
