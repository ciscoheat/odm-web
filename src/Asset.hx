import js.Browser;
import haxe.Json;
import ds.Action;
import mithril.M;

typedef State = {
	final name : String;
}

class Asset extends DeepState<Asset, State> {}

class Container extends DeepStateContainer<Asset, State> {
	public function new() {
        var asset = new Asset(Asset.defaultState());
		super(asset, [redraw]);
	}

    function redraw(asset : Asset, next : Action -> Asset, action : Action) : Asset {
        var newState = next(action);

        M.redraw();

        var debugData = Json.stringify(newState.state, null, "  ").trim();
        Browser.document.getElementById("debug").innerHTML = '<pre>$debugData</pre>';

        return newState;
    }
}
