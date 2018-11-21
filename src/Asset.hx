import ds.ImmutableArray;
import ds.Action;
import mithril.M;
using DateTools;

typedef Wheel = {
	final values : ImmutableArray<String>;
	final currentPosition : Int;
	final spinStart : Float;
}

class Asset extends DeepState<Wheel> {
    final log = new MiddlewareLog<Wheel>();

	public function new(values) {        
		super({values: values, currentPosition: 0, spinStart: 0.0}, [log.log]);
        
		this.subscribeToState((_, _) -> {
            M.redraw();
            var last = log.logs[log.logs.length-1];
            trace(last.timestamp.format("[%T]") + " " + last.type);
        });        
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

class MiddlewareLog<T> {
    public function new() {}

    public final logs = new Array<{state: T, type: String, timestamp: Date}>();

    public function log(state: T, next : Action -> T, action : Action) : T {
        // Get the next state
        var newState = next(action);

        // Log it and return it unchanged
        logs.push({state: newState, type: action.type, timestamp: Date.now()});
        return newState;
    }
}