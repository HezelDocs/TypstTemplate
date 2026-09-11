#import "logos.typ": logo-row
#import "@preview/linguify:0.5.0": linguify

// Shared, sober, conventional title page used identically by `report` and
// `specification` (not style-dependent — same look regardless of `style:`).
// `subtitle` is for a document-type label under the title (e.g.
// "Cahier des charges" for specification); pass none to omit it.
#let title-cover(
  logos: (),
  title: [],
  subtitle: none,
  authors: (),
  supervisors: (),
  mandants: (),
  submitted-to: [],
  faculty: [],
  date: none,
) = {
  set align(center)
  set text(fill: black)
  show link: underline

  logo-row(logos)
  v(2em)

  text(size: 30pt, weight: "bold")[#title]
  if subtitle != none {
    v(0.4em)
    text(size: 14pt, style: "italic")[#subtitle]
  }

  v(3em)
  text(size: 12pt)[#linguify("by")]
  linebreak()
  text(size: 13pt)[#for a in authors {
    a.firstname + " " + a.lastname
    if a != authors.last() { ", " }
  }]
  if supervisors.len() > 0 {
    linebreak()
    text(size: 12pt)[#linguify("supervised_by")]
    linebreak()
    text(size: 13pt)[#for s in supervisors {
      s.firstname + " " + s.lastname
      if s != supervisors.last() { ", " }
    }]
  }
  if mandants.len() > 0 {
    linebreak()
    text(size: 12pt)[#linguify("mandated_by")]
    linebreak()
    text(size: 13pt)[#for m in mandants {
      m.firstname + " " + m.lastname + " (" + m.society + ")"
      if m != mandants.last() { ", " }
    }]
  }

  v(2.5em)
  text(size: 12pt)[#linguify("submitted_to")]
  linebreak()
  text(size: 12pt)[#submitted-to]
  linebreak()
  text(size: 12pt)[#linguify("faculty_of")]
  linebreak()
  text(size: 12pt)[#faculty]

  if date != none {
    v(2em)
    text(size: 12pt)[#date]
  }
}
