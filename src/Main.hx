import ds.ImmutableArray;
import haxe.Json;
import haxe.Timer;
import js.Browser;
import mithril.M;

class Router implements Mithril
{
	final spinWheel : SpinWheel;
	final list : TextBox;

	public function new(spinWheel, list) {
		this.spinWheel = spinWheel;
		this.list = list;
	}

	public function view(vnode) {
		var showingList = M.routeGet() == "/list";
		[
			m('main', vnode.children),
			m('footer', [
				m('img#spin[src="spinning-arrows.svg"]', {
					onclick: () -> {
						M.routeSet.bind("/");
						spinWheel.spin();
					}
				}),
				m('img#list[src="list.svg"]', {
					onclick: () -> {
						var nextRoute = if(showingList) "/" else "/list";
						M.routeSet(nextRoute);
					},
					style: showingList ? {opacity: 0.7} : null
				})
			])
		];
	}

	public function routes() return {
		"/": {
			render: _ -> m(this, spinWheel.view())
		},
		"/list": {
			render: _ -> m(this, list.view())
		}
	}
}

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
		var start = asset.wheelStarted(Timer.stamp());
		var randomDelay = 25;
		var maxDelay = 800;

		(function turn() {
			// Test if new spin started
			if(asset.state.spinStart != start) return;

			var diff = Timer.stamp() - start;

			if(diff > totalTime) {
				stop();
				ping.play();
			} else {
				var delay = (diff / totalTime) * maxDelay + Std.random(randomDelay);

				asset.wheelTurns();
				click.play();

				Timer.delay(turn, Std.int(delay));
			}
		})();
	}

	function stop() {
		asset.wheelStopped();
	}

	public function view() {
		m("h1", {
			"class": asset.state.spinStart != 0.0 ? "spinning" : "",
			onremove: stop,
			oncreate: spin
		}, currentValue());
	}

	inline function currentValue() {
		var wheel = asset.state;
		return wheel.values[wheel.currentPosition % wheel.values.length];
	}
}

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
			var array : Array<String> = Json.parse(current);
			if(Std.is(array, Array)) asset.valuesUpdated(array);
		}
	}

	function save(newValues : String) {
		var values = newValues.trim().split("\n");
		Browser.getLocalStorage().setItem(localStorageKey, Json.stringify(values));
		asset.valuesUpdated(values);
	}

	public function view() {
		m('textarea', {
			oninput: M.withAttr("value", save), 
			value: asset.state.values.join("\n")
		});
	}
}

extern class Howl {
	public function new(options : {});
	public function play() : Void;
}

class Main
{
	public function new() {
		var listKey = "list";
		var defaultValues : ImmutableArray<String> = ["60-tal", "Svenskt", "Dansband", "70-tal", "Pop", "90-tal", "Reggae", "80-tal", "Disco", "Alt. rock", "Klassisk rock", "Hårdrock", "Schlager", "Soundtrack"];
		var spinTime = 8;

		var asset = new Asset(defaultValues);

		var list = new TextBox(asset, listKey);
		var spinWheel = new SpinWheel(asset);

		var router = new Router(spinWheel, list);

		M.route(Browser.document.body, "/", router.routes());
	}

	static function main() new Main();
}