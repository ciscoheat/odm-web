import haxe.Timer;
import js.Browser;
import mithril.M;

typedef State = {
	final values : ds.ImmutableArray<String>;
	final wheelPosition : Int;
	final spinning : Bool;
}

class CIA extends DeepState<State>
{
	public function new(values) {
		super({
			values: values,
			wheelPosition: 0,
			spinning: false
		});
	}

	public function spinWheel() {
		var value : Int = Std.random(state.values.length);
		updateMap([
			state.spinning => true,
			state.wheelPosition => value
		]);
	}

	public function wheelMoves() {
		updateIn(state.wheelPosition, pos -> pos + 1);
	}

	public function wheelStops() {
		updateIn(state.spinning, false);
	}	
}

class Wheel implements Mithril
{
	final asset : CIA;

	public function new(asset) {
		this.asset = asset;
	}

	public function view()
		m(".banner", 
			m('.banner-text', 
				m("h1", {"class": asset.state.spinning ? "spinning" : ""}, currentValue())
			)
		);

	function currentValue() {
		var values = asset.state.values;
		return values[asset.state.wheelPosition % values.length];
	}
}

extern class Howl {
	public function new(options : {});
	public function play() : Void;
}

class Main
{
	public function new() {
		var asset = new CIA(["60-tal", "Svenskt", "Dansband", "70-tal", "Pop", "90-tal", "Reggae", "80-tal", "Disco", "Alt. rock", "Brittiskt", "Klassisk rock", "Hårdrock"]);

		asset.subscribeToState((prev, curr) -> M.redraw());
		M.mount(Browser.document.body, new Wheel(asset));

		var ping = new Howl({src: ["ping.mp3"]});
		var click = new Howl({src: ["click.mp3"]});

		var totalTime = 8; // seconds, approximately
		var minDelay = 20;
		var maxDelay = 1000;
		var start = Timer.stamp();

		function turn() {
			var diff = Timer.stamp() - start;
			if(diff > totalTime) {
				asset.wheelStops();
				ping.play();
				return;
			} else {
				var delay = (diff / totalTime) * maxDelay + minDelay;
				asset.wheelMoves();
				click.play();
				Timer.delay(turn, Std.int(delay));
			}
		}
		asset.spinWheel();
		turn();
	}

	static function main() new Main();
}