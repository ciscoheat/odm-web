import haxe.Timer;
import js.Browser;
import mithril.M;

class Wheel implements Mithril
{
	final values : ds.ImmutableArray<String>;
	final ping = new Howl({src: ["ping.mp3"]});
	final click = new Howl({src: ["click.mp3"]});

	var spinning : Float = 0;
	var wheelPosition : Int = 0;

	public function new(values) {
		this.values = values;
	}

	public function spin(totalTime : Int) {
		var start = spinning = Timer.stamp();
		wheelPosition = Std.random(values.length);

		var randomDelay = 30;
		var maxDelay = 800;

		(function turn() {
			if(spinning != start) return;

			var diff = Timer.stamp() - start;
			if(diff > totalTime) return stop();

			var delay = (diff / totalTime) * maxDelay + Std.random(randomDelay);

			wheelPosition++;
			M.redraw();
			click.play();

			Timer.delay(turn, Std.int(delay));
		})();
	}

	public function stop() {
		spinning = 0;
		ping.play();
		M.redraw();
	}

	public function view()
		m(".banner", 
			m('.banner-text', 
				m("h1", {"class": spinning != 0 ? "spinning" : ""}, currentValue())
			)
		);

	function currentValue() {
		return values[wheelPosition % values.length];
	}
}

extern class Howl {
	public function new(options : {});
	public function play() : Void;
}

class Main
{
	public function new() {
		var values = ["60-tal", "Svenskt", "Dansband", "70-tal", "Pop", "90-tal", "Reggae", "80-tal", "Disco", "Alt. rock", "Klassisk rock", "Hårdrock", "Schlager", "Soundtrack"];
		var wheel = new Wheel(values);
		var body = Browser.document.body;

		M.mount(body.querySelector('main'), wheel);

		wheel.spin(8);

		body.querySelector('#spin').addEventListener('click', wheel.spin.bind(8));
	}

	static function main() new Main();
}