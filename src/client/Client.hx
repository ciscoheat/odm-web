import haxe.Timer;
import mithril.M;
import js.Browser;

class Client
{
	static function main() {
		var element = Browser.document.querySelector("#client");
		var asset = new Asset([]);

		new Router(asset).start(element);

		var eventUrl = 'http://127.0.0.1:8081/events';
		M.request(eventUrl).then(events -> {
			asset.update(asset.state.events = events);
		});
	}
}

// Controller
private class Router
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
