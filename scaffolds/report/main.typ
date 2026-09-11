#import "@local/hezel-templates:0.1.0": chapter-header, linguify, report
#import "data/metadata.typ": (
  authors, experts, mandants, metadata, supervisors, versions,
)

#show: report.with(
  metadata: metadata,
  authors: authors,
  supervisors: supervisors,
  experts: experts,
  mandants: mandants,
  versions: versions,
  logos: metadata.logos.map(f => image("asset/logos/" + f, width: 100%)),
)

// ---------- Front matter (unnumbered, not in the outline) ----------

// ---------- Revision History

#chapter-header(linguify("table_version")) <table_versions>
#include "table/table_versions.typ"

// ---------- Abstract & Keywords

#pagebreak()
#chapter-header(linguify("summary")) <abstract>
#include "section/summary.typ"

// ---------- Acronyms

#pagebreak()
#chapter-header(linguify("acronyms")) <acronyms>
#include "section/acronyms.typ"

// ---------- Glossary

#pagebreak()
#chapter-header(linguify("glossary")) <glossary>
#include "bibliography/glossary.typ"

// ---------- Table of Figures

#pagebreak()
#chapter-header(linguify("table_illustrations")) <table_illustrations>
#include "table/table_illustrations.typ"

// ---------- Table of Tables

#pagebreak()
#chapter-header(linguify("table_of_tables")) <table_of_tables>
#include "table/table_of_tables.typ"

// ---------- Table of Contents

#pagebreak()
#include "table/table_contents.typ"

// ---------- Body (numbered, in the outline) ----------

// ---------- Introduction

#pagebreak()
= #linguify("introduction") <introduction>
#include "section/introduction.typ"

// ---------- State of the Art

#pagebreak()
= #linguify("state_of_the_art") <state_of_the_art>
#include "section/state_of_the_art.typ"

// ---------- Methodology

#pagebreak()
= #linguify("methodology") <methodology>
#include "section/methodology.typ"

// ---------- Results

#pagebreak()
= #linguify("results") <results>
#include "section/results.typ"

// ---------- Discussion

#pagebreak()
= #linguify("discussion") <discussion>
#include "section/discussion.typ"

// ---------- Conclusion & Perspectives

#pagebreak()
= #linguify("conclusion_perspectives") <conclusion>
#include "section/conclusion.typ"

// ---------- Back matter ----------

// ---------- Acknowledgements

#pagebreak()
= #linguify("acknowledgements") <acknowledgements>
#include "section/acknowledgements.typ"

// ---------- References

#pagebreak()
= #linguify("table_references") <table_references>
#include "table/table_references.typ"

// ---------- Appendices (optional — remove this section entirely if unused)

#pagebreak()
= #linguify("annexes") <annexes>

#let appendix(body) = {
  set heading(supplement: [#linguify("appendice")])
  counter(heading).update(13)
  body
}
#show: appendix

#include "bibliography/annexes.typ"
