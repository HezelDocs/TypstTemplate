# Typst Templates

## Quick start

```bash
# 1. Install the package once
./script/install.sh

# 2. Scaffold a new project
./script/new-project.sh report ~/Projects/MyReport

# 3. Fill in your metadata
$EDITOR ~/Projects/MyReport/data/metadata.typ

# 4. Compile
typst compile ~/Projects/MyReport/main.typ
```

Re-run `./script/install.sh` whenever you modify the package source. Run `./script/test.sh` to verify all templates still compile after a change (it reinstalls automatically before testing).

---

## Available templates

| Template | Command | Use case |
|---|---|---|
| `report` | `./script/new-project.sh report <dest>` | Full academic/project report |
| `practicalWork` | `./script/new-project.sh practicalWork <dest>` | Simplified practical work report |
| `minutesMeeting` | `./script/new-project.sh minutesMeeting <dest>` | Meeting minutes (PV) |
| `minutesAgenda` | `./script/new-project.sh minutesAgenda <dest>` | Meeting agenda |
| `specification` | `./script/new-project.sh specification <dest>` | Project specification |

---

## Repository structure

```
typstTemplate/
├── typst.toml              # Package manifest (name, version, entrypoint)
├── lib.typ                 # Package entry point — re-exports everything
├── common/
│   ├── colors.typ          # Shared color palette (c1–c4)
│   └── utils.typ           # resolve-tr(), lang, gender, title enums
├── templates/
│   ├── practical-work.typ  # Layout function + default translations
│   ├── report.typ          # Layout function + chapter-header helper
│   ├── minutes-meeting.typ # Full meeting minutes renderer
│   ├── minutes-agenda.typ  # Full meeting agenda renderer
│   └── specification.typ   # Project specification layout (French)
├── install.sh              # Copies package to ~/.local/share/typst/packages/local/
├── new-project.sh          # Scaffolds a new project from a template directory
│
├── report/                 # Scaffold + example for the report template
├── practicalWork/          # Scaffold + example for the practical work template
├── minutesMeeting/         # Scaffold + example for the meeting minutes template
├── minutesAgenda/          # Scaffold + example for the meeting agenda template
└── specification/          # Scaffold + example for the specification template
```

Each template directory is both a working example and a scaffold — `new-project.sh` copies one of them to start your project.

---

## Package API

Import anything from the package using:

```typst
#import "@local/hezel-templates:0.1.0": <name>
```

### Template functions

All templates are used as show rules:

```typst
#show: <template-name>.with( /* params */ )
```

| Export | Type | Parameters |
|---|---|---|
| `practical-work` | show rule | `metadata`, `authors`, `logo` |
| `report` | show rule | `metadata`, `authors`, `supervisors`, `experts`, `versions`, `logo` |
| `minutes-meeting` | show rule | `minute`, `actors`, `talks`, `tasks`, `logo` |
| `minutes-agenda` | show rule | `agenda`, `actors`, `goals`, `logo` |
| `specification` | show rule | `report`, `project`, `entity`, `authors`, `supervisors`, `mandants`, `experts`, `versions`, `logo` |

### Utilities

| Export | Description |
|---|---|
| `resolve-tr(dict, lang)` | Resolve `{key: {fr: ..., en: ...}}` → `{key: value}` for given lang |
| `chapter-header(title)` | Styled h1-like block excluded from the table of contents |
| `colors` | Color palette: `c1` (dark blue) `c2` `c3` `c4` (beige) |
| `lang` | Enum: `lang.en`, `lang.fr` |
| `gender` | Enum: `gender.m`, `gender.f` |
| `tr-practical-work` | Default bilingual translations for practical work chapters |
| `tr-report` | Default bilingual translations for report chapters |
| `tr-minutes-meeting` | Default bilingual translations for meeting minutes |
| `tr-minutes-agenda` | Default bilingual translations for meeting agenda |

---

## Project anatomy

### Practical work / Report

After scaffolding, a project looks like this:

```
my-report/
├── main.typ               # Imports package + lists sections
├── data/
│   └── metadata.typ       # Title, authors, dates, entity — edit this
├── section/
│   ├── introduction.typ
│   ├── implementation.typ
│   └── conclusion.typ
└── asset/
    └── logos/
        └── logo_hes-so.png
```

`main.typ` for a practical work:

```typst
#import "@local/hezel-templates:0.1.0": practical-work, tr-practical-work, resolve-tr
#import "data/metadata.typ": metadata, authors

#let t = resolve-tr(tr-practical-work, metadata.lang)

#show: practical-work.with(
  metadata: metadata,
  authors: authors,
  logo: image("asset/logos/" + metadata.logo, width: 50%),
)

#pagebreak()
= #t.introduction <introduction>
#include "section/introduction.typ"

#pagebreak()
= #t.implementation <implementation>
#include "section/implementation.typ"

#pagebreak()
= #t.conclusion <conclusion>
#include "section/conclusion.typ"
```

### Meeting minutes / Agenda

These templates are fully data-driven — no section files needed:

```
my-meeting/
├── main.typ
└── data/
    └── minute_data.typ    # Meeting info, actors, talks, tasks — edit this
```

`main.typ`:

```typst
#import "@local/hezel-templates:0.1.0": minutes-meeting
#import "data/minute_data.typ": minute, actors, talks, tasks

#show: minutes-meeting.with(
  minute: minute,
  actors: actors,
  talks: talks,
  tasks: tasks,
  logo: image("asset/" + minute.logo, width: 30%),
)
```

---

## Testing

After modifying the package source (`common/` or `templates/`), run:

```bash
./script/test.sh
```

This reinstalls the package and compiles all 5 scaffold templates. Output example:

```
Installing package...

Running template compilation tests...
--------------------------------------
  PASS  report
  PASS  practicalWork
  PASS  minutesMeeting
  PASS  minutesAgenda
  PASS  specification
--------------------------------------
Results: 5 passed, 0 failed
```

Exit code is non-zero if any template fails, so it works in CI too.

---

## Updating the package

The package source lives in this repository. Changes to `lib.typ`, `common/`, or `templates/` are not live until you reinstall:

```bash
./script/install.sh
```

To bump the version, edit `typst.toml` and update the version string in all project `main.typ` imports accordingly.

---

## Colors

All templates share the same palette, accessible as `colors.c1` through `colors.c4`:

| Name | Hex | Preview |
|---|---|---|
| `c1` | `#001f3f` | Dark navy (headings, primary blocks) |
| `c2` | `#3a6d8c` | Medium blue (secondary elements) |
| `c3` | `#6a9ab0` | Light blue (table headers, accents) |
| `c4` | `#ead8b1` | Beige (highlight boxes) |

Use in any project file:

```typst
#import "@local/hezel-templates:0.1.0": colors

#rect(fill: colors.c4)[highlighted content]
```

Or via the local re-export (already present in scaffold):

```typst
#import "../data/styling.typ": colors
```
