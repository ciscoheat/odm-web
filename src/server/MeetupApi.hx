import haxe.Json;
import haxe.Http;

class MeetupApi
{
    final group : String;

    public function new(group : String) {
        this.group = group;
    }

	public function events(datelimit = "") {
		var apiKey = DotEnv.get("MEETUP_API_KEY");
		var url = 'https://api.meetup.com/$group/events?sign=true&photo-host=public&status=past,upcoming&key=$apiKey&desc=true';
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