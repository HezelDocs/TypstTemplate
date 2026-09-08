#import "@local/hezel-templates:0.1.0": minutes-agenda
#import "data/agenda_data.typ": actors, agenda, goals

#show: minutes-agenda.with(
  agenda: agenda,
  actors: actors,
  goals: goals,
  logo: image("asset/" + agenda.logo, width: 30%),
)
