import Asset;
import js.Browser;
import js.Promise;
import mithril.M;
import ds.ImmutableArray;

using DateTools;

/////////////////////////////////////////////////////////////////////

class Client
{
	static function main() {
		var url = 'http://localhost:8081';
		M.request(url).then(events -> {
			new Router(
				new Asset(events), 
				Browser.document.body.querySelector("#client")
			);
		});
	}
}

/////////////////////////////////////////////////////////////////////

class Router implements Mithril
{
	final asset : Asset;

	public function new(asset, element) {
		this.asset = asset;

		M.route(element, "/", {
			"/": {
				render: _ -> {
					trace("New EventList");
					layout(new EventList(asset.state.events));
				}
			}
		});
	}

	function layout(view : Component) 
		m('.flex-vertical.flex-center', m('.container', [
			m('header.flex-center', m('img[src=logo.png]#logo')),
			m(view)
		]));
}

/////////////////////////////////////////////////////////////////////

private class EventList implements Mithril
{
	final events : ImmutableArray<Event>;

	public function new(events)
		this.events = events;

	public function view() cast [
		events.filter(e -> e.status == Upcoming).map(eventView),
		cast m('h2', 'Past meetups'),
		events.filter(e -> e.status == Past).map(eventView)
	];

	function eventView(e : Event)
		m('article', [
			m('time', Date.fromTime(e.time).format("%Y-%m-%d")),
			m('h3', e.name),
			m('a', {href: e.link, target: "_blank"}, "RSVP here")
		]);
}
