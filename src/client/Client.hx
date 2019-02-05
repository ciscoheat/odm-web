import haxe.Timer;
import mithril.M;
import js.Browser;

class Client
{
	static function main() {
		var element = Browser.document.querySelector("#client");

		//M.mount(element, new HelloWorld());

		var asset = new Asset([]);
		new Router(asset).start(element);

		var eventUrl = 'http://localhost:8081/events';
		M.request(eventUrl).then(events -> {
			asset.update(asset.state.events = events);
		});

		/*
		function updateTitle() {
			var names = [
				"Short End of the Stick",
				"If You Can't Stand the Heat, Get Out of the Kitchen",
				"What Goes Up Must Come Down",
				"Money Doesn't Grow On Trees",
				"Don't Count Your Chickens Before They Hatch"
			];
			var randomName = names[Std.random(names.length)];
			var index = Std.random(asset.state.events.length);

			asset.update(asset.state.events[index].name = randomName, "NewTitle");
		}

		var t = new Timer(100);
		t.run = updateTitle;
		*/
	}
}

class HelloWorld implements Mithril
{
	public function new() {}

	public function view() 
		m('h1', "Hello World!");
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
