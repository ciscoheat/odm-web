import ds.ImmutableArray;
import mithril.M;

typedef Wheel = {
	final values : ImmutableArray<String>;
	final currentPosition : Int;
	final spinStart : Float;
}

class Asset extends DeepState<Wheel> {
	public function new(values) {
		super({values: values, currentPosition: 0, spinStart: 0.0});
		this.subscribeToState((_, _) -> M.redraw());
	}

	public function valuesUpdated(values) {
		updateIn(state.values, values);
	}

	public function wheelTurns() {
		updateIn(state.currentPosition, pos -> pos+1);
	}

	public function wheelStopped() {
		return updateIn(state.spinStart, 0.0).spinStart;
	}

	public function wheelStarted(time) {
		return updateIn(state.spinStart, time).spinStart;
	}
}