#import "@local/hezel-templates:0.1.0": minutes-meeting
#import "data/minute_data.typ": actors, minute, talks, tasks

#show: minutes-meeting.with(
  minute: minute,
  actors: actors,
  talks: talks,
  tasks: tasks,
  logo: image("asset/" + minute.logo, width: 30%),
)
