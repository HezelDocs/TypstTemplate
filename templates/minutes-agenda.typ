#import "../common/colors.typ": colors
#import "../common/utils.typ": resolve-tr

#let tr-minutes-agenda = (
  meeting_agenda_of:    (fr: "Agenda de séance du",       en: "Meeting Agenda of"),
  meeting_details:      (fr: "Détails de la séance",      en: "Meeting Details"),
  session_goals:        (fr: "Objectifs de la séance",    en: "Session Objectives"),
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
)

#let minutes-agenda(agenda: (:), actors: (), goals: (), logo: none, body) = {
  set text(region: "ch", lang: agenda.lang, font: "Roboto")
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

  let t = resolve-tr(tr-minutes-agenda, agenda.lang)

  // Extract chairman and scribe
  let scribe = ""
  let chairman = ""
  for a in actors {
    if a.isChairman { chairman = a.lastname + " " + a.firstname }
    if a.isScribe   { scribe   = a.lastname + " " + a.firstname }
    if chairman != "" and scribe != "" { break }
  }

  // ---- Content ----

  [= #t.meeting_agenda_of #agenda.seance_date.display()]

  [== #agenda.project_scope]

  text(size: 15pt, weight: "medium", fill: colors.c1)[#agenda.project_name]

  [== #t.meeting_details]

  show table.cell.where(x: 0): set text(size: 12pt, fill: white)
  set table(fill: (x, _) => if x == 0 { colors.c3 })

  table(
    columns: (22%, 78%),
    align: horizon,
    [*#t.location*], [#agenda.location_name – #agenda.location_street – #agenda.location_npa #agenda.location_locality],
    [*#t.room*],     [#agenda.location_room],
    [*#t.date*],     [#agenda.seance_date.display()],
    [*#t.schedule*], [#agenda.schedule],
  )

  table(
    columns: (22%, 78%),
    align: horizon,
    [*#t.meeting_chair*],         [#chairman],
    [*#t.minute_taker*],          [#scribe],
    [*#t.expected_participants*], [
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

  [== #t.session_goals]

  show table.cell.where(x: 0): set text(size: 11pt, fill: black)
  show table.cell.where(y: 0): set text(size: 12pt, fill: white)
  set table(fill: (_, y) => if y == 0 { colors.c3 }, align: left + horizon)

  table(
    columns: (20%, 80%),
    table.header[*#t.duration_min*][*#t.objectives*],
    ..for goal in goals { (str(goal.duration), goal.desc) }
  )

  body
}
