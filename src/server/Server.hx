import php.SuperGlobal;
import php.Lib;
import haxe.Json;
import haxe.Http;
import php.Web;

using DateTools;

class Server
{
	static function main() {
		var serverVars = Lib.hashOfAssociativeArray(SuperGlobal._SERVER);
		var pathInfo : String = serverVars.get("PATH_INFO");
		var paths = pathInfo == null ? [] : pathInfo.split("/").filter(p -> p.length > 0);

		switch paths {
			case ['events']:
				var url = 'https://api.meetup.com/ovik-dev/events?sign=true&photo-host=public&status=past,upcoming&key=2b2f2e93f54332315755310656a&desc=true';
				var data = Http.requestUrl(url);

				var events : ds.ImmutableArray<Event> = cast Json.parse(data);
				var dateLimit = Date.now().delta(-1000*60*60*24*90).getTime();
				var newerEvents = events.filter(e -> e.time > dateLimit);

				Web.setHeader("Content-type", "application/json");
				Web.setHeader("Access-Control-Allow-Origin", "*");

				Sys.print(Json.stringify(newerEvents));
				
			case _:
				Web.setReturnCode(404);
		}
	}
}
