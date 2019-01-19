import js.Browser;
import haxe.Json;
import ds.Action;
import mithril.M;

using StringTools;

typedef State = {
	final events : ds.ImmutableArray<Event>;
}

class Asset extends DeepStateContainer<State> {
	public function new(events) {
        var asset = new DeepState<State>({
            events: events
        }, [redraw]);

		super(asset);
	}

    function redraw(asset, next : Action -> ds.gen.DeepState<State>, action) {
        var newState = next(action);
        M.redraw();
        return newState;
    }
}
