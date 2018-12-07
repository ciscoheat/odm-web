import haxe.Json;
import js.Browser;
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

class Asset extends DeepState<Asset, Wheel> {}

class Container extends DeepStateContainer<Asset, Wheel> {
    final log = new MiddlewareLog<Asset, Wheel>();

	public function new(values) {
        var asset = new Asset({values: values, currentPosition: 0, spinTime: 0.0});
		super(asset, [redraw, log.log]);
	}

    function redraw(asset : Asset, next : Action -> Asset, action : Action) : Asset {
        var newState = next(action);

        if(log.logs.length > 0) {
            var last = log.logs[log.logs.length-1];
            var actions = '[' + last.action.updates.map(a -> '${a.path} => ${a.value}').join('] [') + ']';
            trace(last.timestamp.format("[%T]") + " " + last.action.type + " " + actions);
        }

        M.redraw();

        var debugData = Json.stringify(newState.state, null, "  ").trim();
        Browser.document.getElementById("debug").innerHTML = '<pre>$debugData</pre>';

        return newState;
    }
}

/////////////////////////////////////////////////////////////////////

class MiddlewareLog<S : DeepState<S,T>, T> {
    public function new() {}

    public final logs = new Array<{action: Action, timestamp: Date}>();

    public function log(asset: S, next : Action -> S, action : Action) : S {
        // Get the next state
        var newState = next(action);

        // Log it and return it unchanged
        logs.push({action: action, timestamp: Date.now()});
        return newState;
    }
}