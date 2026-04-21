#import "@local/hezel-templates:0.1.0": practical-work, linguify
#import "data/metadata.typ": metadata, authors

#show: practical-work.with(
  metadata: metadata,
  authors: authors,
  logo: image("asset/logos/" + metadata.logo, width: 50%),
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
