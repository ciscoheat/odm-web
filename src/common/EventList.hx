import mithril.M;
import ds.ImmutableArray;

using DateTools;

// View
class EventList implements Mithril
{
	final events : ImmutableArray<MeetupEvent>;

	public function new(events)
		this.events = events;

	public function view() cast [
		events.filter(e -> e.status == Upcoming).map(eventView),
		cast m('h2', 'Past meetups'),
		events.filter(e -> e.status == Past).map(eventView)
	];

	function eventView(e : MeetupEvent)
		m('article', [
			m('time', Date.fromTime(e.time).format("%Y-%m-%d")),
			m('h3', e.name),			
			m('a', {href: e.link, target: "_blank"}, e.status == Upcoming ? "RSVP here" : "More info")
		]);
}