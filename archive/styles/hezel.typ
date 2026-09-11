// ARCHIVED — the "hezel" style (navy blocks, white bold headings) has been
// retired from the active template set; only the sober/academic look is
// used now (see common/base-style.typ). Kept here for reference in case
// it's wanted again later. Not imported by anything, not installed by
// script/install.sh (which only packages common/, templates/, lib.typ and
// typst.toml).
//
// If you want to bring it back: restore common/styles/hezel.typ (this
// file, paths unchanged since it still sits one level under a styles/
// directory), restore the styles-dict dispatch in common/base-style.typ,
// and re-add the `style:` parameter to report/practical-work/specification
// in templates/. See git history around the "remove hezel style" commit
// for the exact prior shape of that system.

// colors.typ was NOT archived — common/colors.typ is still used by
// minutes-meeting/minutes-agenda, which keep their branded hezel look.
#import "../../common/colors.typ": colors
#import "@preview/linguify:0.5.0": set-database

#let apply-doc-base(lang: "en", body) = {
  set page(
    flipped: false,
    margin: (bottom: 2cm, top: 2cm, x: 1.5cm),
    paper: "a4",
  )
  set text(
    font: "Times New Roman",
    lang: lang,
    region: "ch",
    size: 11pt,
    weight: "regular",
  )
  show link: set text(fill: blue.darken(60%))
  set-database(toml("../../common/lang.toml"))
  body
}

#let default-level3(it) = {
  set align(left)
  set text(size: 17pt, weight: "medium", fill: colors.c1)
  it
}

#let doc-heading(it, level3: default-level3) = {
  if it.level == 1 [
    #set align(center)
    #set text(size: 30pt, weight: "extrabold", fill: white)
    #block(fill: colors.c1, width: 100%, inset: 10pt, it)
    #v(10pt)
  ] else if it.level == 2 [
    #set align(left)
    #set text(size: 25pt, weight: "bold", fill: colors.c1)
    #(it)
    #v(-17pt)
    #line(stroke: 2pt + colors.c1, length: 100%)
    #v(5pt)
  ] else if it.level == 3 {
    level3(it)
  }
}
