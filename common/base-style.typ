// Sober, black-on-white, conventional document style used by report,
// practical-work and specification: no colored fills, numbered headings,
// justified paragraphs with first-line indent.
//
// (There used to be a second, colored "hezel" style selectable via a
// `style:` parameter — it's been retired and archived under archive/
// styles/hezel.typ. minutes-meeting/minutes-agenda still use that look,
// but inline, not through this file.)

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
    size: 12pt,
    weight: "regular",
    fill: black,
  )
  set par(first-line-indent: 2.5em, justify: true, leading: 1em)
  show link: underline
  set-database(toml("lang.toml"))
  body
}

#let default-level3(it) = {
  set text(size: 12pt, weight: "bold", style: "italic", fill: black)
  it
}

#let doc-heading(it, level3: default-level3) = {
  if it.level == 1 [
    #pagebreak(weak: true)
    #v(1em)
    #set align(left)
    #set text(size: 20pt, weight: "bold", fill: black)
    #it
    #v(1em)
  ] else if it.level == 2 [
    #v(1em)
    #set text(size: 14pt, weight: "bold", fill: black)
    #it
    #v(0.4em)
  ] else if it.level == 3 {
    v(0.8em)
    level3(it)
    v(0.2em)
  }
}
