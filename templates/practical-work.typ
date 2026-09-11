#import "../common/base-style.typ": apply-doc-base, doc-heading
#import "../common/cover-page.typ": title-cover
#import "@preview/linguify:0.5.0": linguify

#let practical-work(
  metadata: (:),
  authors: (),
  logos: (),
  body,
) = apply-doc-base(lang: metadata.lang, {
  set list(indent: 5pt, spacing: 0.8em, body-indent: 0.4em, marker: (
    [•],
    [◦],
    [⁃],
  ))
  set enum(indent: 5pt, spacing: 0.8em, body-indent: 0.4em)

  // Cover page — identical to `report`/`specification` (common/cover-
  // page.typ), the only differences being the course name appended after
  // the faculty, and the submission date + repository URL added after the
  // creation date.
  {
    title-cover(
      logos: logos,
      title: metadata.name,
      authors: authors,
      submitted-to: metadata.entity,
      faculty: [#metadata.section #linebreak() #metadata.course],
      date: [
        #linguify("date_creation") : #metadata.date_creation.display()
        #linebreak()
        #linguify("date_rendu") : #metadata.date_due.display()
        #linebreak()
        #linguify("repository_uri") : #link(metadata.git_url)[#metadata.git_url]
      ],
    )
    pagebreak()
  }

  set page(numbering: "1/1")
  show heading: doc-heading

  body
})
