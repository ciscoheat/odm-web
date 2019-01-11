import Asset;
import js.Browser;
import mithril.M;

/////////////////////////////////////////////////////////////////////

class Main
{
	static function main() {
		var asset = new Asset();
		new Router(asset).enableRoutes(
			Browser.document.body.querySelector("#app")
		);
	}
}

/////////////////////////////////////////////////////////////////////

class Router implements Mithril
{
	final asset : Asset;
	final helloWorld : HelloWorld;

	public function new(asset) {
		this.asset = asset;
		this.helloWorld = new HelloWorld(asset);
	}

	public function enableRoutes(element) {
		M.route(element, "/", {
			"/": {
				render: _ -> layout(helloWorld)
			}
		});
	}

	function layout(view : Component) [
		m('header'),
		m('main', m(view)),
		m('footer', [
			m('a[href=/]', {oncreate: M.routeLink}, "Start"),
			m('a[href]', {
				onclick: () -> {
					asset.update(
						asset.state.name =
						["World", "Mithril", "Haxe", "DeepState"][Std.random(4)]
					);
					return false;
				}

			}, "Change")
		])
	];
}

/////////////////////////////////////////////////////////////////////

class HelloWorld implements Mithril
{
	final asset : Asset;

	public function new(asset) {
		this.asset = asset;
	}

	public function view() [
		m("h1", "Hello " + asset.state.name),
		m("p", "Lorem ipsum?")
	];
}
