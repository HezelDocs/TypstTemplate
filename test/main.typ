#import "@local/hezel-templates:0.1.0": report, chapter-header, colors, linguify
#import "data/metadata.typ": metadata, authors, supervisors, experts, versions

#show: report.with(
  metadata: metadata,
  authors: authors,
  supervisors: supervisors,
  experts: experts,
  versions: versions,
  logo: image("asset/logos/" + metadata.logo, width: 50%),
)

// ---------- Table of Versions

#chapter-header(linguify("table_version")) <table_versions>
#include "table/table_versions.typ"

// ---------- Executive Summary

#pagebreak()
#chapter-header(linguify("summary")) <executive_summary>
#include "section/summary.typ"

// ---------- Table of Contents

#pagebreak()
#include "table/table_contents.typ"

// ---------- Introduction

#pagebreak()
= #linguify("introduction") <introduction>
#include "section/introduction.typ"

// ---------- Context

#pagebreak()
= #linguify("contexte") <context>
#include "section/context.typ"

// ---------- Analysis

#pagebreak()
= #linguify("analysis") <analysis>
#include "section/analysis.typ"

// ---------- Conception

#pagebreak()
= #linguify("conception") <conception>
#include "section/conception.typ"

// ---------- Implementation

#pagebreak()
= #linguify("implementation") <implementation>
#include "section/implementation.typ"

// ---------- Testing and Validation

#pagebreak()
= #linguify("testing") <testing>
#include "section/testing.typ"

// ---------- Potential Developments

#pagebreak()
= #linguify("potential_dev") <potentiel_dev>
#include "section/potentiel_dev.typ"

// ---------- Conclusion

#pagebreak()
= #linguify("conclusion") <conclusion>
#include "section/conclusion.typ"

// ---------- Declaration of Honor

#pagebreak()
= #linguify("honor") <honor>
#include "section/honor.typ"

// ---------- Acknowledgements

#pagebreak()
= #linguify("acknowledgements") <acknowledgements>
#include "section/acknowledgements.typ"

// ---------- Glossary

#pagebreak()
#chapter-header(linguify("glossary")) <glossary>
#include "bibliography/glossary.typ"

// ---------- Table of References

#pagebreak()
= #linguify("table_references") <table_references>
#include "table/table_references.typ"

// ---------- Table of Illustrations

#pagebreak()
= #linguify("table_illustrations") <table_illustrations>
#include "table/table_illustrations.typ"

// ---------- Annexes

#pagebreak()
= #linguify("annexes") <annexes>

#let appendix(body) = {
  set heading(supplement: [#linguify("appendice")])
  counter(heading).update(13)
  body
}
#show: appendix

#include "bibliography/annexes.typ"
