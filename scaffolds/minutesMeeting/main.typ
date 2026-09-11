#import "@local/hezel-templates:0.1.0": minutes-meeting
#import "data/minute_data.typ": actors, minute, talks, tasks

#show: minutes-meeting.with(
  minute: minute,
  actors: actors,
  talks: talks,
  tasks: tasks,
  logos: minute.logos.map(f => image("asset/" + f, width: 100%)),
)
