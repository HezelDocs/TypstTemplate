#import "@local/hezel-templates:0.1.0": report, tr-report, resolve-tr, chapter-header, colors
#import "data/metadata.typ": metadata, authors, supervisors, experts, versions

#let t = resolve-tr(tr-report, metadata.lang)

#show: report.with(
  metadata: metadata,
  authors: authors,
  supervisors: supervisors,
  experts: experts,
  versions: versions,
  logo: image("asset/logos/" + metadata.logo, width: 50%),
)

// ---------- Table of Versions

#chapter-header(t.table_version) <table_versions>
#include "table/table_versions.typ"

// ---------- Executive Summary

#pagebreak()
#chapter-header(t.summary) <executive_summary>
#include "section/summary.typ"

// ---------- Table of Contents

#pagebreak()
#include "table/table_contents.typ"

// ---------- Introduction

#pagebreak()
= #t.introduction <introduction>
#include "section/introduction.typ"

// ---------- Context

#pagebreak()
= #t.contexte <context>
#include "section/context.typ"

// ---------- Analysis

#pagebreak()
= #t.analysis <analysis>
#include "section/analysis.typ"

// ---------- Conception

#pagebreak()
= #t.conception <conception>
#include "section/conception.typ"

// ---------- Implementation

#pagebreak()
= #t.implementation <implementation>
#include "section/implementation.typ"

// ---------- Testing and Validation

#pagebreak()
= #t.testing <testing>
#include "section/testing.typ"

// ---------- Potential Developments

#pagebreak()
= #t.potential_dev <potentiel_dev>
#include "section/potentiel_dev.typ"

// ---------- Conclusion

#pagebreak()
= #t.conclusion <conclusion>
#include "section/conclusion.typ"

// ---------- Declaration of Honor

#pagebreak()
= #t.honor <honor>
#include "section/honor.typ"

// ---------- Acknowledgements

#pagebreak()
= #t.acknowledgements <acknowledgements>
#include "section/acknowledgements.typ"

// ---------- Glossary

#pagebreak()
#chapter-header(t.glossary) <glossary>
#include "bibliography/glossary.typ"

// ---------- Table of References

#pagebreak()
= #t.table_references <table_references>
#include "table/table_references.typ"

// ---------- Table of Illustrations

#pagebreak()
= #t.table_illustrations <table_illustrations>
#include "table/table_illustrations.typ"

// ---------- Annexes

#pagebreak()
= #t.annexes <annexes>

#let appendix(body) = {
  set heading(supplement: [#t.appendice])
  counter(heading).update(13)
  body
}
#show: appendix

#include "bibliography/annexes.typ"
