#import "@local/hezel-templates:0.1.0": practical-work, tr-practical-work, resolve-tr
#import "data/metadata.typ": metadata, authors

#let t = resolve-tr(tr-practical-work, metadata.lang)

#show: practical-work.with(
  metadata: metadata,
  authors: authors,
  logo: image("asset/logos/" + metadata.logo, width: 50%),
)

// ---------- Introduction

#pagebreak()
= #t.introduction <introduction>
#include "section/introduction.typ"

// ---------- Implementation

#pagebreak()
= #t.implementation <implementation>
#include "section/implementation.typ"

// ---------- Conclusion

#pagebreak()
= #t.conclusion <conclusion>
#include "section/conclusion.typ"
