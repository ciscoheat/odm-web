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
		Timer.delay(() -> {
			asset.update(asset.state.events[0].name = "Super full stack Haxe magic!", "Mega update");
		}, 2000);
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
