#import "@local/hezel-templates:0.1.0": specification
#import "./values/metadata.typ": report, project, entity, authors, supervisors, mandants, experts, versions

#show: specification.with(
  report: report,
  project: project,
  entity: entity,
  authors: authors,
  supervisors: supervisors,
  mandants: mandants,
  experts: experts,
  versions: versions,
  logo: image("assets/logo_heia.svg", width: 100%),
)

// ---------- Table des versions

= Table des versions <table_versions>
#include "section/table_versions.typ"

// ---------- Table des matières

#pagebreak()
#include "section/table_contents.typ"

// ---------- Glossaire

#pagebreak()
= Glossaire <glossary>
#include "bibliography/glossary.typ"

// ---------- Contexte

#pagebreak()
= Contexte <context>
#include "section/context.typ"

// ---------- Objectifs

#pagebreak()
= Objectifs <goals>
#include "section/goals.typ"

// ---------- Activités

#pagebreak()
= Activités <activities>
#include "section/activities.typ"

// ---------- Planning

#pagebreak()
#include "section/planning.typ"

// ---------- Table des références

#pagebreak()
= Table des références <table_references>
#include "section/table_references.typ"

// ---------- Table des illustrations

#pagebreak()
= Table des illustrations <table_illustations>
#include "section/table_illustrations.typ"
