import php.SuperGlobal;
import php.Lib;
import php.Web;
import haxe.Json;
import haxe.Http;

class Server
{
	static function main() {
		var serverVars = Lib.hashOfAssociativeArray(SuperGlobal._SERVER);
		var pathInfo : String = serverVars.get("PATH_INFO");
		var paths = pathInfo == null ? [] : pathInfo.split("/").filter(p -> p.length > 0);

		switch paths {
			case ['events'], ['events', 'after', _]:
				var dateLimit = paths.length == 3
					? Date.fromString(paths[2]).getTime()
					: 0;

				var url = 'https://api.meetup.com/ovik-dev/events?sign=true&photo-host=public&status=past,upcoming&key=2b2f2e93f54332315755310656a&desc=true';
				var data = Http.requestUrl(url);
				var allEvents : ds.ImmutableArray<Event> = cast Json.parse(data);

				var displayEvents = dateLimit > 0
					? allEvents.filter(e -> e.time > dateLimit)
					: allEvents;

				Web.setHeader("Content-type", "application/json");
				Web.setHeader("Access-Control-Allow-Origin", "*");

				Lib.print(Json.stringify(displayEvents));

			case _:
				Web.setReturnCode(404);
		}
	}
}
