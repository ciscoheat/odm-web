import haxe.Json;
import haxe.Http;
import meetup.MeetupEvent;

class MeetupApi
{
    final group : String;

    public function new(group : String) {
        this.group = group;
    }

	public function events(timestampFrom = 0.0) {
		var apiKey = DotEnv.get("MEETUP_API_KEY");
		var url = 'https://api.meetup.com/$group/events?sign=true&photo-host=public&status=past,upcoming&key=$apiKey&desc=true';
		var data = Http.requestUrl(url);

		var allEvents : ds.ImmutableArray<MeetupEvent> = cast Json.parse(data);

		// Date filtering
		var displayEvents = allEvents.filter(e -> e.time >= timestampFrom);
		return displayEvents;
	}
}