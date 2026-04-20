// -------------------------------------------------------------------
// Copyright © 2024 Dimitri Julmy
// License MIT
// -------------------------------------------------------------------
// Author : Dimitri Julmy <dim.julmy@gmail.com>
// Date   : 18 May 2025
// -------------------------------------------------------------------
// Metadata of the specifications
// -------------------------------------------------------------------

// ---------- Imports

// Third-party

// Values

// ---------- Report

#let report = (
  name: [Cahier des charges],
  date_creation: datetime(year: 2024, month: 09, day: 22),
  date_due: datetime.today(),
)

// ---------- Project

#let project = (
  scope: [Projet de semestre/bachelor / Autre],
  name: [Titre du projet],
  git_url: "https://example.com/",
  duration: 18, // weeks
  credits: 4,
  hours_per_credit: 30,
)

// ---------- Entity

#let entity = (
  name: [Haute école d'ingénierie et d'architecture Fribourg],
  acronym: [HEIA],
  sector: [Filière Informatique et Systèmes de Communication],
  orientation: [Informatique logicielle],
  locality: [Fribourg],
  year: [3ème année],
)

// ---------- Author.s

#let authors = (
  (
    firstname: [],
    lastname: [],
    gender: [],
    title: [],
  ),
)

// ---------- Supervisor.s

#let supervisors = (
  (
    firstname: [],
    lastname: [],
    gender: [],
    title: [],
  ),
)

// ---------- Mandant.s

#let mandants = (
  (
    firstname: [],
    lastname: [],
    gender: [],
    title:[],
    society: [],
    url: ""
  ),
)

// ---------- Experts.s

#let experts = (
  (
    firstname: [],
    lastname: [],
    gender: [],
    title: [],
  ),
)

// ---------- Document version (from the oldest to the newest)

#let versions = (
  (
    version: "0.0",
    date: datetime(year: 2025, month: 05, day: 18),
    changes: [Création du document],
  ),
)
