#import "../common/colors.typ": colors
#import "../common/base-style.typ": apply-doc-base, doc-heading
#import "@preview/linguify:0.5.0": linguify

// specification's level-3 headings get their own filled block, unlike the
// plain colored text used by report/practical-work.
#let spec-level3(it) = {
  set align(left)
  set text(size: 17pt, weight: "medium", fill: white)
  block(fill: colors.c3, width: 100%, inset: 7pt, it)
}

#let specification(
  report: (:),
  project: (:),
  entity: (:),
  authors: (),
  supervisors: (),
  mandants: (),
  experts: (),
  versions: (),
  lang: "fr",
  logo: none,
  body,
) = apply-doc-base(lang: lang, {
  set list(indent: 5pt, spacing: 0.8em, body-indent: 0.4em, marker: (
    [•],
    [◦],
    [⁃],
  ))
  set enum(indent: 5pt, spacing: 0.8em, body-indent: 0.4em)

  // Cover page
  {
    if logo != none { logo }
    v(17pt)

    set line(length: 100%)
    stack(line(stroke: 2pt + colors.c1))
    v(7pt)
    set align(center)
    text(fill: colors.c1, size: 45pt, weight: "extrabold")[#project.name]
    v(7pt)
    stack(line(stroke: 2pt + colors.c1))
    v(12pt)

    set align(left)
    text(
      fill: colors.c2,
      size: 28pt,
      weight: "bold",
    )[#project.scope - #project.name]
    v(15pt)

    set table(
      stroke: none,
      gutter: 0.2em,
      fill: (x, _) => if x == 0 { colors.c2 } else { colors.c3 },
      inset: 8pt,
    )
    show table.cell: it => {
      set align(horizon + left)
      if it.x == 0 {
        set text(fill: white, size: 17pt, weight: "bold")
        it
      } else {
        set text(fill: white, size: 15pt, weight: "semibold")
        it
      }
    }
    show link: underline

    table(
      columns: (25%, 75%),
      [#linguify("school")], [#entity.name],
      [#linguify("sector")], [#entity.sector],
      [#linguify("orientation")], [#entity.orientation],
      [#linguify("year")], [#entity.year],
      [#linguify("author")],
      [#for a in authors {
        if a == authors.first() { a.lastname + " " + a.firstname } else {
          ", " + a.lastname + " " + a.firstname
        }
      }],

      [#linguify("supervisors")],
      [#for s in supervisors {
        if s == supervisors.first() { s.lastname + " " + s.firstname } else {
          ", " + s.lastname + " " + s.firstname
        }
      }],

      [#linguify("locality")], [#entity.locality],
      [#linguify("date_creation")], [#report.date_creation.display()],
      [#linguify("date_rendu")], [#datetime.today().display()],
      [#linguify("version")], [#versions.last().version],
      [#linguify("gitlab")], [#link(project.git_url)[#linguify("gitlab_url")]],
    )

    pagebreak()
    pagebreak()
  }

  set page(numbering: "1/1")
  set list(indent: 2em, tight: true)
  set par(first-line-indent: 2.5em, justify: true, leading: 1em)
  set heading(level: auto, depth: 3, numbering: "1.1.", outlined: true)
  show heading: it => doc-heading(it, level3: spec-level3)

  body
})
