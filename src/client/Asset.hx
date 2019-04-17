import mithril.M;
import meetup.MeetupEvent;

typedef State = {
	final events : ds.ImmutableArray<MeetupEvent>;
}

class Asset extends DeepStateContainer<State> {
	public function new(events) {
		var state = {
			events: events
		};
		var asset = new DeepState<State>(state, [redraw]);
		
		super(asset);
	}

    function redraw(asset, next : ds.Action -> ds.gen.DeepState<State>, action) {
        var newState = next(action);
        M.redraw();
        return newState;
    }
}
