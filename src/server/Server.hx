import haxe.Json;
import haxe.Http;
import php.Web;

class Server
{
	static function main() {
		var url = 'https://api.meetup.com/ovik-dev/events?sign=true&photo-host=public&status=past,upcoming&key=2b2f2e93f54332315755310656a&desc=true';
		var data = Http.requestUrl(url);

		Web.setHeader("Content-type", "application/json");
		Web.setHeader("Access-Control-Allow-Origin", "*");
		
		Sys.print(data);
	}
}
