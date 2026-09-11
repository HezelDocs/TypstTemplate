#import "../common/base-style.typ": apply-doc-base, doc-heading
#import "../common/cover-page.typ": title-cover
#import "@preview/linguify:0.5.0": linguify

// Same visual treatment as a level-1 heading (see doc-heading in
// common/base-style.typ), for manually-inserted chapter titles that are
// excluded from the numbered heading/TOC flow (Revision History,
// Executive Summary, Glossary, Annexes...).
#let chapter-header(title) = {
  v(1em)
  set align(left)
  text(size: 20pt, weight: "bold", fill: black, title)
  v(1em)
}

#let report(
  metadata: (:),
  authors: (),
  supervisors: (),
  experts: (),
  mandants: (),
  versions: (),
  logos: (),
  body,
) = apply-doc-base(lang: metadata.lang, {
  set list(indent: 5pt, spacing: 0.8em, body-indent: 0.4em, marker: (
    [•],
    [◦],
    [⁃],
  ))
  set enum(indent: 5pt, spacing: 0.8em, body-indent: 0.4em)

  // Cover page — shared with `specification` via common/cover-page.typ, so
  // the two stay identical.
  {
    title-cover(
      logos: logos,
      title: metadata.name,
      authors: authors,
      supervisors: supervisors,
      mandants: mandants,
      submitted-to: metadata.entity,
      faculty: metadata.section,
      date: metadata.date_creation.display(),
    )
    pagebreak()
    pagebreak()
  }

  set page(numbering: "1/1")
  set heading(level: auto, depth: 3, numbering: "1.1.", outlined: true)
  show heading: doc-heading

  body
})
