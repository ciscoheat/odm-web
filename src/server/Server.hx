import php.SuperGlobal;
import php.Lib;
import php.Web;
import haxe.Json;
import haxe.Http;

class Server
{
	static final SERVER = Lib.hashOfAssociativeArray(SuperGlobal._SERVER);

	static function main() {
		var pathInfo : String = SERVER["PATH_INFO"];
		var paths = pathInfo == null ? [] : pathInfo.split("/").filter(p -> p.length > 0);		

		try switch paths {
			case ['crash']:
				throw "You crashed on purpose!";

			case ['macro']:
				trace(DotEnv.get("MEETUP_API_KEY"));

			case ['events'], ['events', 'after', _]:

				var apiKey = DotEnv.get("MEETUP_API_KEY");
				var url = 'https://api.meetup.com/ovik-dev/events?sign=true&photo-host=public&status=past,upcoming&key=$apiKey&desc=true';
				var data = Http.requestUrl(url);
				var allEvents : ds.ImmutableArray<MeetupEvent> = cast Json.parse(data);

				// Date filtering
				var dateLimit = paths.length == 3 ? Date.fromString(paths[2]).getTime()	: 0;
				var displayEvents = dateLimit > 0
					? allEvents.filter(e -> e.time > dateLimit)
					: allEvents;

				outputJson(displayEvents);

			case _:
				Web.setReturnCode(404);
		}
		catch(e : Dynamic) {
			Web.setReturnCode(500);
			Lib.print('<h1>Internal server error</h1>');
			Lib.print('<pre>');
			Lib.dump(e);
			Lib.print('</pre>');
		}
	}

	static function outputJson(data : Dynamic) {
		Web.setHeader("Content-type", "application/json");
		Web.setHeader("Access-Control-Allow-Origin", "*");
		Lib.print(Json.stringify(data));
	}
}
