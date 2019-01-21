import ds.Action;
import mithril.M;

typedef State = {
	final events : ds.ImmutableArray<MeetupEvent>;
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
        trace(action.type);
        M.redraw();
        return newState;
    }
}
