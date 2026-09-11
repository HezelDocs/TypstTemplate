#import "../common/base-style.typ": apply-doc-base, doc-heading
#import "../common/cover-page.typ": title-cover
#import "@preview/linguify:0.5.0": linguify

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
  logos: (),
  body,
) = apply-doc-base(lang: lang, {
  set list(indent: 5pt, spacing: 0.8em, body-indent: 0.4em, marker: (
    [•],
    [◦],
    [⁃],
  ))
  set enum(indent: 5pt, spacing: 0.8em, body-indent: 0.4em)

  // Cover page — shared with `report` via common/cover-page.typ, so the
  // two stay identical. `subtitle` carries the "Cahier des charges"
  // document-type label that's specific to specification.
  {
    title-cover(
      logos: logos,
      title: project.name,
      subtitle: report.name,
      authors: authors,
      supervisors: supervisors,
      mandants: mandants,
      submitted-to: entity.name,
      faculty: entity.sector,
      date: report.date_creation.display(),
    )
    pagebreak()
    pagebreak()
  }

  set page(numbering: "1/1")
  set list(indent: 2em, tight: true)
  set par(first-line-indent: 2.5em, justify: true, leading: 1em)
  set heading(level: auto, depth: 3, numbering: "1.1.", outlined: true)
  show heading: doc-heading

  body
})
