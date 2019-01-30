import mithril.M;
import ds.ImmutableArray;

using DateTools;

class Client
{
	static function main() {
		var asset = new Asset([]);
		var eventUrl = 'http://localhost:8081/events';

		new Router(asset, js.Browser.document.querySelector("#client"));

		M.request(eventUrl).then(events -> {
			asset.update(asset.state.events = events);
		});
	}
}

// Controller + View
private class Router implements Mithril
{
	final asset : Asset;
	final layout : Layout;

	public function new(asset, element) {
		this.asset = asset;
		this.layout = new Layout();

		M.route(element, "/", {
			"/": {
				render: _ -> layout.layout(new EventList(asset.state.events))
			}
		});
	}
}
