#import "colors.typ": colors
#import "@preview/linguify:0.5.0": set-database

#let apply-doc-base(lang: "en", body) = {
  set page(
    flipped: false,
    margin: (bottom: 2cm, top: 2cm, x: 1.5cm),
    paper: "a4",
  )
  set text(
    font: "Roboto",
    lang: lang,
    region: "ch",
    size: 11pt,
    weight: "regular",
  )
  show link: set text(fill: blue.darken(60%))
  set-database(toml("lang.toml"))
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
