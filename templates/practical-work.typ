#import "../common/colors.typ": colors
#import "../common/utils.typ": resolve-tr

#let tr-practical-work = (
  introduction:   (fr: "Introduction",  en: "Introduction"),
  implementation: (fr: "Implémentation", en: "Implementation"),
  conclusion:     (fr: "Conclusion",     en: "Conclusion"),
)

#let _tr-cover = (
  date_creation: (fr: "Date de création", en: "Creation date"),
  date_rendu:    (fr: "Date de rendu",    en: "Submission date"),
  gitlab:        (fr: "GitLab",           en: "GitLab"),
)

#let practical-work(metadata: (:), authors: (), logo: none, body) = {
  set page(flipped: false, margin: (bottom: 2cm, top: 2cm, x: 1.5cm), paper: "a4")
  set text(font: "Roboto", lang: metadata.lang, region: "ch", size: 11pt, weight: "regular")
  show link: set text(fill: blue.darken(60%))
  set list(indent: 5pt, spacing: 0.8em, body-indent: 0.4em, marker: ([•], [◦], [⁃]))
  set enum(indent: 5pt, spacing: 0.8em, body-indent: 0.4em)

  let tc = resolve-tr(_tr-cover, metadata.lang)

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
      [Repository URI],   [#link(metadata.git_url)[#metadata.git_url]],
      [#tc.date_creation], [#metadata.date_creation.display()],
      [#tc.date_rendu],   [#datetime.today().display()],
    )

    pagebreak()
  }

  set page(numbering: "1/1")

  show heading: it => {
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
      #v(0pt)
    ] else if it.level == 3 [
      #set align(left)
      #set text(size: 17pt, weight: "medium", fill: colors.c1)
      #(it)
    ]
  }

  body
}
