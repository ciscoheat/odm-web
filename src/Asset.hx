import ds.ImmutableArray;
import ds.Action;
import mithril.M;
using DateTools;

/////////////////////////////////////////////////////////////////////

typedef Wheel = {
	final values : ImmutableArray<String>;
	final currentPosition : Int;
	final spinTime : Float;
}

/////////////////////////////////////////////////////////////////////

class Asset extends DeepState<Wheel> {
    final log = new MiddlewareLog<Wheel>();

	public function new(values) {        
		super({values: values, currentPosition: 0, spinTime: 0.0}, [log.log]);

		this.subscribeTo((_, _) -> {
            M.redraw();
            var last = log.logs[log.logs.length-1];
            var actions = '[' + last.action.updates.map(a -> '${a.path} => ${a.value}').join('] [') + ']';
            trace(last.timestamp.format("[%T]") + " " + last.action.type + " " + actions);
        });        
	}
}

/////////////////////////////////////////////////////////////////////

class MiddlewareLog<T> {
    public function new() {}

    public final logs = new Array<{action: Action, timestamp: Date}>();

    public function log(state: T, next : Action -> T, action : Action) : T {
        // Get the next state
        var newState = next(action);

        // Log it and return it unchanged
        logs.push({action: action, timestamp: Date.now()});
        return newState;
    }
}