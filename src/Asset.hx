import ds.ImmutableArray;
import mithril.M;

typedef State = {
	final values : ImmutableArray<String>;
	final spinStart : Float;
	final currentPosition : Int;
}

class Asset extends DeepState<State>
{
	public static final current = new Asset();

	public function new() {
		super({
			values: [],
			spinStart: 0,
			currentPosition: 0
		}, [redrawMithril]);
	}

    public function newValues(v : ImmutableArray<String>) {
        updateIn(state.values, v);
    }

    public function startSpin() {
        var newState = updateMap([
            state.spinStart => haxe.Timer.stamp(),
            state.currentPosition => Std.random(state.values.length)
        ]);
        return newState.spinStart;
    }

    public function stopSpin() {
        updateIn(state.spinStart, 0);
    }

    public function turnWheel() {
        updateIn(state.currentPosition, p -> (p + 1) % state.values.length);
    }

    ///// Middleware /////

	function redrawMithril(state, next, action) : State {
		js.Browser.window.setTimeout(M.redraw, 0);
		return next(action);
	}
}