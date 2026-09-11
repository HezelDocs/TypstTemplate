#import "@local/hezel-templates:0.1.0": linguify, practical-work
#import "data/metadata.typ": authors, metadata

#show: practical-work.with(
  metadata: metadata,
  authors: authors,
  logos: metadata.logos.map(f => image("asset/logos/" + f, width: 100%)),
)

// ---------- Introduction

#pagebreak()
= #linguify("introduction") <introduction>
#include "section/introduction.typ"

// ---------- Implementation

#pagebreak()
= #linguify("implementation") <implementation>
#include "section/implementation.typ"

// ---------- Conclusion

#pagebreak()
= #linguify("conclusion") <conclusion>
#include "section/conclusion.typ"
