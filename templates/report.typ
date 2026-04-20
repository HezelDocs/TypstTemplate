#import "../common/colors.typ": colors
#import "../common/utils.typ": resolve-tr

#let tr-report = (
  table_version:      (fr: "Table des versions",       en: "Revision History"),
  summary:            (fr: "Résumé",                   en: "Abstract"),
  table_content:      (fr: "Table des matières",       en: "Table of Contents"),
  introduction:       (fr: "Introduction",             en: "Introduction"),
  contexte:           (fr: "Contexte",                 en: "Context"),
  analysis:           (fr: "Analyse",                  en: "Analysis"),
  conception:         (fr: "Conception",               en: "Design"),
  implementation:     (fr: "Implémentation",           en: "Implementation"),
  testing:            (fr: "Tests et validations",     en: "Testing & Validation"),
  potential_dev:      (fr: "Évolutions possibles",     en: "Possible Improvements"),
  conclusion:         (fr: "Conclusion",               en: "Conclusion"),
  honor:              (fr: "Déclaration sur l'honneur", en: "Declaration of Honor"),
  acknowledgements:   (fr: "Remerciements",            en: "Acknowledgements"),
  glossary:           (fr: "Glossaire",                en: "Glossary"),
  table_references:   (fr: "Table des références",     en: "References"),
  table_illustrations:(fr: "Table des illustrations",  en: "List of Figures"),
  annexes:            (fr: "Annexes",                  en: "Appendices"),
  appendice:          (fr: "Annexe",                   en: "Appendix"),
)

#let _tr-cover = (
  entite:       (fr: "Entité",              en: "Entity"),
  section:      (fr: "Filière",            en: "Program"),
  profil:       (fr: "Orientation",        en: "Specialization"),
  year:         (fr: "Année",              en: "Year"),
  autor:        (fr: "Auteur·s",           en: "Author(s)"),
  supervisor:   (fr: "Superviseur·s",      en: "Supervisor(s)"),
  expert:       (fr: "Expert·s",           en: "Expert(s)"),
  locality:     (fr: "Lieu",               en: "Location"),
  date_creation:(fr: "Date de création",   en: "Creation date"),
  date_rendu:   (fr: "Date de rendu",      en: "Submission date"),
  version:      (fr: "Version",            en: "Version"),
  gitlab:       (fr: "GitLab",             en: "GitLab"),
)

// Non-outlined chapter header: same visual as h1 but excluded from ToC.
#let chapter-header(title) = {
  set align(center)
  block(
    fill: colors.c1,
    width: 100%,
    inset: 10pt,
    text(size: 30pt, weight: "extrabold", fill: white, title),
  )
  v(10pt)
}

#let report(
  metadata: (:),
  authors: (),
  supervisors: (),
  experts: (),
  versions: (),
  logo: none,
  body,
) = {
  set page(flipped: false, margin: (bottom: 2cm, top: 2cm, x: 1.5cm), paper: "a4")
  set text(font: "Roboto", lang: metadata.lang, region: "ch", size: 11pt, weight: "regular")
  show link: set text(fill: blue.darken(60%))
  set list(indent: 5pt, spacing: 0.8em, body-indent: 0.4em, marker: ([•], [◦], [⁃]))
  set enum(indent: 5pt, spacing: 0.8em, body-indent: 0.4em)

  let tc = resolve-tr(_tr-cover, metadata.lang)

  // Cover page
  {
    if logo != none { align(center, logo) }
    v(17pt)

    set line(length: 100%)
    stack(line(stroke: 2pt + colors.c1))
    v(7pt)
    set align(center)
    text(fill: colors.c1, size: 45pt, weight: "extrabold")[#metadata.name]
    v(7pt)
    stack(line(stroke: 2pt + colors.c1))
    v(12pt)

    set align(left)
    text(fill: colors.c2, size: 28pt, weight: "bold")[#metadata.scope - #metadata.type]
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
        set text(fill: white, size: 15pt, weight: "bold")
        it
      } else {
        set text(fill: white, size: 15pt, weight: "semibold")
        it
      }
    }
    show link: underline

    table(
      columns: (25%, 75%),
      [#tc.entite],       [#metadata.entity],
      [#tc.section],      [#metadata.section],
      [#tc.profil],       [#metadata.profil],
      [#tc.year],         [#metadata.year],
      [#tc.autor],        [#for a in authors {
                              a.firstname + " " + a.lastname
                              if a != authors.last() { ", " }
                            }],
      [#tc.supervisor],   [#for s in supervisors {
                              s.firstname + " " + s.lastname
                              if s != supervisors.last() { ", " }
                            }],
      [#tc.expert],       [#for e in experts {
                              e.firstname + " " + e.lastname
                              if e != experts.last() { ", " }
                            }],
      [#tc.locality],     [#metadata.locality],
      [#tc.date_creation],[#metadata.date_creation.display()],
      [#tc.date_rendu],   [#datetime.today().display()],
      [#tc.version],      [#versions.last().version],
      [#tc.gitlab],       [#link(metadata.git_url)],
    )

    pagebreak()
    pagebreak()
  }

  set page(numbering: "1/1")
  set heading(level: auto, depth: 3, numbering: "1.1.", outlined: true)

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
      #v(5pt)
    ] else if it.level == 3 [
      #set align(left)
      #set text(size: 17pt, weight: "medium", fill: colors.c1)
      #(it)
    ]
  }

  body
}
