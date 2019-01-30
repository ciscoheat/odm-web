import mithril.MithrilNodeRender;
import sys.io.File;
import php.SuperGlobal;
import php.Lib;
import php.Web;
import haxe.Json;
import haxe.Http;

using StringTools;

class Server
{
	static final SERVER = Lib.hashOfAssociativeArray(SuperGlobal._SERVER);

	static function main() {
		var pathInfo : String = SERVER["PATH_INFO"];
		var paths = pathInfo == null ? [] : pathInfo.split("/").filter(p -> p.length > 0);

		try switch paths {
			case []:
				var layout = new Layout();				
				var html = File.getContent("index.html");
				var eventList = new EventList(MeetupApi.get());
				var content = new MithrilNodeRender("  ").render(layout.layout(eventList));
				
				outputHtml(html
					.replace('<div id="client"></div>', '<div id="client">\n$content\n</div>')
					.replace('<script src="client.js"></script>', '')
				);

			case ['crash']:
				throw "You crashed on purpose!";

			case ['macro']:
				trace(DotEnv.get("MEETUP_API_KEY"));

			case ['events']:
				outputJson(MeetupApi.get());

			case ['events', 'after', _]:
				outputJson(MeetupApi.get(paths[2]));

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

	static function outputHtml(html : String) {
		Lib.print(html);
	}

	static function outputJson(data : Dynamic) {
		Web.setHeader("Content-type", "application/json");
		Web.setHeader("Access-Control-Allow-Origin", "*");
		Lib.print(Json.stringify(data));
	}
}

class MeetupApi
{
	public static function get(datelimit = "") {
		var apiKey = DotEnv.get("MEETUP_API_KEY");
		var url = 'https://api.meetup.com/ovik-dev/events?sign=true&photo-host=public&status=past,upcoming&key=$apiKey&desc=true';
		var data = Http.requestUrl(url);

		var allEvents : ds.ImmutableArray<MeetupEvent> = cast Json.parse(data);

		// Date filtering
		var dateLimit = datelimit.length > 0 
			? Date.fromString(datelimit).getTime() 
			: 0;

		var displayEvents = dateLimit > 0
			? allEvents.filter(e -> e.time > dateLimit)
			: allEvents;

		return displayEvents;
	}
}