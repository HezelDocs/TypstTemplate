#import "../common/colors.typ": colors
#import "../common/utils.typ": resolve-tr

#let tr-minutes-meeting = (
  meeting_minutes_of:   (fr: "PV de séance du",          en: "Meeting Minutes of"),
  meeting_details:      (fr: "Détails de la séance",      en: "Meeting Details"),
  agenda:               (fr: "Ordre du jour",             en: "Agenda"),
  discussions:          (fr: "Discussions",               en: "Discussions"),
  key_points:           (fr: "Points Essentiels",         en: "Key Points"),
  location:             (fr: "Lieu",                      en: "Location"),
  room:                 (fr: "Salle",                     en: "Room"),
  date:                 (fr: "Date",                      en: "Date"),
  schedule:             (fr: "Horaire",                   en: "Schedule"),
  meeting_chair:        (fr: "Président.e de séance",     en: "Meeting Chair"),
  minute_taker:         (fr: "Scribe de séance",          en: "Minute Taker"),
  expected_participants:(fr: "Participant.es prévu.es",   en: "Expected Participants"),
  excused:              (fr: "Excusé.es",                 en: "Excused"),
  duration_min:         (fr: "Durée [min.]",              en: "Duration [min.]"),
  objectives:           (fr: "Objectifs",                 en: "Objectives"),
  decision_taken:       (fr: "Décision.s prise.s",        en: "Decision(s) Taken"),
  objective_s:          (fr: "Objectif.s",                en: "Objective(s)"),
  decision_s:           (fr: "Décision.s",                en: "Decision(s)"),
  tasks:                (fr: "Tâche.s",                   en: "Task(s)"),
  description:          (fr: "Description",               en: "Description"),
  assignee:             (fr: "Exécutant",                 en: "Assignee"),
  due_date:             (fr: "Échéance",                  en: "Due Date"),
)

#let minutes-meeting(minute: (:), actors: (), talks: (), tasks: (), logo: none, body) = {
  set text(region: "ch", lang: minute.lang, font: "Roboto")
  set page(margin: (top: 3cm, bottom: 3cm, x: 1.5cm))
  if logo != none {
    set page(header: align(center, logo))
  }
  show link: set text(fill: blue.darken(60%))
  set page(numbering: "1/1")
  set list(indent: 5pt, spacing: 0.8em, body-indent: 0.4em, marker: ([•], [◦], [⁃]))

  show heading: it => {
    if it.level == 1 [
      #set align(center)
      #set text(size: 27pt, weight: "extrabold", fill: white)
      #block(fill: colors.c1, width: 100%, inset: 18pt, it.body)
    ] else if it.level == 2 [
      #set align(left)
      #set text(size: 20pt, weight: "bold", fill: white)
      #block(fill: colors.c2, width: 100%, inset: 10pt, it.body)
    ]
  }

  let t = resolve-tr(tr-minutes-meeting, minute.lang)

  // Extract chairman and scribe
  let scribe = ""
  let chairman = ""
  for a in actors {
    if a.isChairman { chairman = a.lastname + " " + a.firstname }
    if a.isScribe   { scribe   = a.lastname + " " + a.firstname }
    if chairman != "" and scribe != "" { break }
  }

  // ---- Content ----

  [= #t.meeting_minutes_of #minute.seance_date.display()]

  [== #minute.project_scope]

  text(size: 15pt, weight: "medium", fill: colors.c1)[#minute.project_name]

  [== #t.meeting_details]

  show table.cell.where(x: 0): set text(size: 12pt, fill: white)
  set table(fill: (x, _) => if x == 0 { colors.c3 })

  table(
    columns: (22%, 78%),
    align: horizon,
    [*#t.location*], [#minute.location_name – #minute.location_street – #minute.location_npa #minute.location_locality],
    [*#t.room*],     [#minute.location_room],
    [*#t.date*],     [#minute.seance_date.display("[day].[month].[year]")],
    [*#t.schedule*], [#minute.schedule],
  )

  table(
    columns: (22%, 78%),
    align: horizon,
    [*#t.meeting_chair*],          [#chairman],
    [*#t.minute_taker*],           [#scribe],
    [*#t.expected_participants*],  [
      #for a in actors {
        if not a.excused {
          if a == actors.first() { a.lastname + " " + a.firstname }
          else { ", " + a.lastname + " " + a.firstname }
        }
      }
    ],
    [*#t.excused*], [
      #for a in actors {
        if a.excused { a.lastname + " " + a.firstname; if a != actors.last() { ", " } }
      }
    ],
  )

  [== #t.agenda]

  show table.cell.where(x: 0): set text(size: 11pt, fill: black)
  show table.cell.where(y: 0): set text(size: 12pt, fill: white)
  set table(fill: (_, y) => if y == 0 { colors.c3 })

  table(
    columns: (20%, 80%),
    table.header[*#t.duration_min*][*#t.objective_s*],
    ..for t-item in talks { (str(t-item.duration), t-item.name) }
  )

  pagebreak()
  [== #t.discussions]

  for talk in talks {
    block(
      breakable: false,
      grid(
        rows: 3,
        columns: 100%,
        grid.cell(y: 0, fill: colors.c3, inset: 7pt,
          text(size: 12pt, weight: "bold", fill: white, talk.name)),
        grid.cell(y: 1, inset: 7pt, talk.desc),
        grid.cell(y: 2, inset: 7pt, [*#t.decision_taken* : #talk.decision]),
      )
    )
  }

  [== #t.key_points]

  table(
    columns: (40%, 60%),
    align: horizon,
    table.header[*#t.objective_s*][*#t.decision_s*],
    ..for talk in talks { (talk.name, talk.decision) }
  )

  table(
    columns: (26%, 50%, 12%, 12%),
    align: (x, _) => if x == 0 or x == 1 { horizon } else { horizon + center },
    table.header[*#t.tasks*][*#t.description*][*#t.assignee*][*#t.due_date*],
    ..for task in tasks {
      (task.name, task.desc, task.exec, task.date_due.display("[day].[month].[year]"))
    }
  )

  body
}
