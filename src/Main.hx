import Asset.Container;
import js.Browser;
import mithril.M;

/////////////////////////////////////////////////////////////////////

class Main
{
	static function main() {
		var container = new Container();
		new Router(container).enableRoutes(
			Browser.document.body.querySelector("#app")
		);
	}
}

/////////////////////////////////////////////////////////////////////

class Router implements Mithril
{
	final container : Container;
	final helloWorld : HelloWorld;

	public function new(container) {
		this.container = container;
		this.helloWorld = new HelloWorld(container);
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
					container.update(
						container.state.name, 
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
	final container : Container;

	public function new(container) {
		this.container = container;
	}

	public function view() {
		m("h1", "Hello " + container.state.name);
	}
}
