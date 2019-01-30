import haxe.Timer;
import mithril.M;

class Client
{
	static function main() {
		var asset = new Asset([]);
		var eventUrl = 'http://localhost:8081/events';

		new Router(asset).start(js.Browser.document.querySelector("#client"));

		M.request(eventUrl).then(events -> {
			asset.update(asset.state.events = events);
		});

		/*
		Timer.delay(() -> {
			asset.update(asset.state.events[0].name = "Super full stack Haxe magic!", "Mega update");
		}, 2000);
		*/
	}
}

// Controller + View
private class Router implements Mithril
{
	final asset : Asset;
	final layout : Layout;

	public function new(asset) {
		this.asset = asset;
		this.layout = new Layout();
	}

	public function start(element) {
		M.route(element, "/", {
			"/": {
				render: _ -> layout.layout(new EventList(asset.state.events))
			}
		});
	}
}
