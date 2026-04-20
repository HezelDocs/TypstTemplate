// Resolve a bilingual dict {key: {fr: ..., en: ...}} to {key: value} based on lang.
#let resolve-tr(dict, lang) = {
  let result = (:)
  for (k, v) in dict.pairs() {
    result.insert(k, if lang == "fr" { v.fr } else { v.en })
  }
  result
}

#let lang = (en: "en", fr: "fr")
#let gender = (m: "male", f: "female")
#let title = (eng: "Engineer", doc: "Doctor", prf: "Professor")
