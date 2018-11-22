import haxe.Json;
import haxe.Timer;
import js.Browser;
import mithril.M;

/////////////////////////////////////////////////////////////////////

class Router implements Mithril
{
	final spinWheel : SpinWheel;
	final list : TextBox;

	public function new(spinWheel, list) {
		this.spinWheel = spinWheel;
		this.list = list;
	}

	function layout(view : Component) {
		[
			m('main', m(view)),
			m('footer', [
				m('a[href=/]', {oncreate: M.routeLink}, 
					m('img[src="spinning-arrows.svg"]')
				),
				m('a', {
					href: M.routeGet() == "/list" ? "/" : "/list",
					oncreate: M.routeLink,
					onupdate: M.routeLink
				}, m('img[src="list.svg"]', {
					style: M.routeGet() == "/list" ? {opacity: 0.7} : null
				}))
			])
		];
	}

	public function routes() return {
		"/": {
			onmatch: () -> spinWheel.spin(),
			render: _ -> layout(spinWheel)
		},
		"/list": {
			onmatch: () -> spinWheel.stop(),
			render: _ -> layout(list)
		}
	}
}

/////////////////////////////////////////////////////////////////////

class SpinWheel implements Mithril
{
	static final ping = new Howl({src: ["ping.mp3"]});
	static final click = new Howl({src: ["click.mp3"]});

	final asset : Asset;

	public function new(asset) {
		this.asset = asset;
	}

	public function spin() {
		var totalTime = 8;
		var randomDelay = 25;
		var maxDelay = 800;

		var start = Timer.stamp();
		asset.updateIn(asset.state.spinTime, start);

		(function nextTurn() {
			// Test if new spin started
			if(asset.state.spinTime != start) return;

			var diff = Timer.stamp() - start;

			if(diff > totalTime) {
				stop();
				ping.play();
			} else {
				var delay = (diff / totalTime) * maxDelay + Std.random(randomDelay);

				turn();
				click.play();

				Timer.delay(nextTurn, Std.int(delay));
			}
		})();
	}

	function turn() {
		asset.updateIn(asset.state.currentPosition, pos -> pos + 1);
	}

	public function stop() {
		asset.updateIn(asset.state.spinTime, 0.0);
	}

	public function view() {
		m("h1", {
			"class": asset.state.spinTime != 0.0 ? "spinning" : "",
		}, currentValue());
	}

	inline function currentValue() {
		var wheel = asset.state;
		return wheel.values[wheel.currentPosition % wheel.values.length];
	}
}

/////////////////////////////////////////////////////////////////////

class TextBox implements Mithril
{
	final localStorageKey : String;
	final asset : Asset;

	public function new(asset, localStorageKey : String) {
		this.asset = asset;
		this.localStorageKey = localStorageKey;
		load();
	}

	function load() {
		var current = Browser.getLocalStorage().getItem(localStorageKey);
		if(current != null) {
			var values : Array<String> = Json.parse(current);
			if(Std.is(values, Array)) {
				asset.updateIn(asset.state.values, values);
			}
		}
	}

	function save(newValues : String) {
		// Cannot trim values here because of user editing. Any empty
		// line at the end will be removed directly. Trim in view.onremove instead.
		var values = newValues.split("\n");
		Browser.getLocalStorage().setItem(localStorageKey, Json.stringify(values));
		asset.updateIn(asset.state.values, values);
	}

	public function view() {
		m('textarea', {
			oninput: M.withAttr("value", save), 
			value: asset.state.values.join("\n"),
			// Trim values when exiting list
			onremove: () -> save(asset.state.values.join("\n").trim())
		});
	}
}

/////////////////////////////////////////////////////////////////////

extern class Howl {
	public function new(options : {});
	public function play() : Void;
}

/////////////////////////////////////////////////////////////////////

class Main
{
	public function new() {
		var defaultValues = ["60-tal", "Svenskt", "Dansband", "70-tal", "Pop", "90-tal", "Reggae", "80-tal", "Disco", "Alt. rock", "Klassisk rock", "Hårdrock", "Schlager", "Soundtrack"];

		var asset = new Asset(defaultValues);

		var list = new TextBox(asset, "list");
		var spinWheel = new SpinWheel(asset);

		M.route(Browser.document.body, "/", new Router(spinWheel, list).routes());
	}

	static function main() new Main();
}