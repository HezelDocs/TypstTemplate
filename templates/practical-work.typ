#import "../common/colors.typ": colors
#import "../common/base-style.typ": apply-doc-base, doc-heading
#import "@preview/linguify:0.5.0": linguify

#let practical-work(
  metadata: (:),
  authors: (),
  logo: none,
  body,
) = apply-doc-base(lang: metadata.lang, {
  set list(indent: 5pt, spacing: 0.8em, body-indent: 0.4em, marker: (
    [•],
    [◦],
    [⁃],
  ))
  set enum(indent: 5pt, spacing: 0.8em, body-indent: 0.4em)

  // Cover page (scoped to avoid leaking set rules into body)
  {
    if logo != none { align(center, logo) }
    v(80pt)

    set align(center)
    text(fill: colors.c1, size: 40pt, weight: "extrabold")[#metadata.name]
    set line(length: 100%)
    stack(line(stroke: 2pt + colors.c1))

    v(40pt)
    text(fill: colors.c1, size: 25pt, weight: "bold")[#metadata.course]

    v(40pt)
    text(fill: black, size: 18pt)[
      #for a in authors {
        a.firstname + " " + a.lastname
        if a != authors.last() { ", " }
      }
    ]
    linebreak()
    text(fill: colors.c1, size: 18pt)[-]
    linebreak()
    text(fill: black, size: 13pt)[#metadata.entity (#metadata.entity_acronym)]
    linebreak()
    text(fill: black, size: 13pt)[#metadata.section (#metadata.section_acronym)]
    linebreak()
    text(fill: black, size: 13pt)[#metadata.profil (#metadata.profil_acronym)]

    v(200pt)
    set align(left)
    table(
      columns: (20%, 80%),
      stroke: none,
      inset: 3pt,
      align: left + horizon,
      [#linguify("repository_uri")],
      [#link(metadata.git_url)[#metadata.git_url]],

      [#linguify("date_creation")], [#metadata.date_creation.display()],
      [#linguify("date_rendu")], [#datetime.today().display()],
    )

    pagebreak()
  }

  set page(numbering: "1/1")
  show heading: doc-heading

  body
})
