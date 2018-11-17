import ds.ImmutableArray;
import haxe.Json;
import haxe.Timer;
import js.Browser;
import mithril.M;
import Asset.current as asset;

class Layout implements Mithril
{

}

class Wheel implements Mithril
{
	final ping = new Howl({src: ["ping.mp3"]});
	final click = new Howl({src: ["click.mp3"]});

	public function new() {
	}

	public function spin(totalTime : Int) {
		var start = asset.startSpin();
		var randomDelay = 30;
		var maxDelay = 800;

		(function turn() {
			// Test if new spin started
			if(asset.state.spinStart != start) return;

			var diff = Timer.stamp() - start;

			if(diff > totalTime) {
				asset.stopSpin();
				ping.play();
				return;
			}

			var delay = (diff / totalTime) * maxDelay + Std.random(randomDelay);

			asset.turnWheel();
			click.play();

			Timer.delay(turn, Std.int(delay));
		})();
	}

	public function view()
		m(".banner",
			m('.banner-text',
				m("h1", {"class": asset.state.spinStart != 0 ? "spinning" : ""}, currentValue())
			)
		);

	function currentValue() {
		return asset.state.values[asset.state.currentPosition];
	}
}

class TextBox implements Mithril
{
	final localStorageKey : String;
	public var values(default, null) : ImmutableArray<String>;

	public function new(defaultValues : ImmutableArray<String>, localStorageKey : String) {
		this.localStorageKey = localStorageKey;
		load(defaultValues);
	}

	function load(defaultValues) {
		var current = Browser.getLocalStorage().getItem(localStorageKey);
		this.values = if(current == null) {
			Browser.getLocalStorage().setItem(localStorageKey, Json.stringify(defaultValues));
			defaultValues;
		} else {
			Json.parse(current);
		}
	}

	function save(newValues : String) {
		this.values = newValues.trim().split("\n");
		Browser.getLocalStorage().setItem(localStorageKey, Json.stringify(this.values));
	}

	public function view() {
		m('textarea', {oninput: M.withAttr("value", save), value: values.join("\n")});
	}
}

extern class Howl {
	public function new(options : {});
	public function play() : Void;
}

class Main
{
	public function new() {
		var state = asset.state;
		var listKey = "list";
		var spinTime = 8;
		var defaultValues = ["60-tal", "Svenskt", "Dansband", "70-tal", "Pop", "90-tal", "Reggae", "80-tal", "Disco", "Alt. rock", "Klassisk rock", "Hårdrock", "Schlager", "Soundtrack"];

		asset.newValues(defaultValues);

		var list = new TextBox(defaultValues, listKey);
		var body = Browser.document.body;
		var wheel = new Wheel();

		M.mount(body.querySelector('main'), {view: function() {
			//return state.list != null ? state.list.view() : state.wheel.view();
			return wheel.view();
		}});

		wheel.spin(spinTime);

		body.querySelector('#spin').addEventListener('click', function() {
			//state.wheel.newValues(state.list.values);
			//state.list = null;
			wheel.spin(spinTime);
		});

		/*
		body.querySelector('#list').addEventListener('click', function() {
			if(state.list == null) {
				state.wheel.stop();
				state.list = new TextBox(defaultValues, listKey);
				M.redraw();
			} else {
				state.wheel.newValues(state.list.values);
				state.list = null;
				state.wheel.spin(spinTime);
			}
		});
		*/
	}

	static function main() new Main();
}