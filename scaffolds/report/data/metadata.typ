#import "@local/hezel-templates:0.1.0": gender, lang

// ---------- Metadata

#let metadata = (
  lang: lang.en,
  // Up to 5 logos (school(s), partner company...), rendered left to right,
  // each getting an equal share of the row's width.
  logos: ("logo_hes-so.png",),
  type: "Report",
  scope: "Scope",
  name: "Project's name",
  git_url: "https://gitlab-url.com",
  date_creation: datetime(year: 2025, month: 09, day: 19),
  date_due: datetime.today(),
  entity: "University of Applied Sciences and Arts of Western Switzerland",
  entity_acronym: "HES-SO",
  section: "Master of Science in Engineering",
  section_acronym: "MSE",
  profil: "Information and cyber security",
  profil_acronym: "ICS",
  locality: "Fribourg",
  year: "3rd year",
)

// ---------- Persons

#let authors = (
  (
    firstname: "Dimitri",
    lastname: "Julmy",
    gender: gender.m,
    locality: "Fribourg",
  ),
)

#let supervisors = (
  (firstname: "John", lastname: "Doe", gender: gender.m),
  (firstname: "Jane", lastname: "Doe", gender: gender.f),
)

#let experts = (
  (firstname: "John", lastname: "Doe", gender: gender.m),
  (firstname: "Jane", lastname: "Doe", gender: gender.f),
)

// Company/organization that mandated the project, if any — leave empty
// () if there is none, the cover page skips the section entirely.
#let mandants = ()

// ---------- Document versions (oldest to newest)

#let versions = (
  (
    version: "0.0",
    date: datetime(year: 2024, month: 09, day: 17),
    changes: [Document creation],
  ),
)
