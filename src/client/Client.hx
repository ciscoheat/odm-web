import Asset;
import js.Browser;
import mithril.M;
import ds.ImmutableArray;

using DateTools;

/////////////////////////////////////////////////////////////////////

class Client
{
	static function main() new Router(
		new Asset(), 
		Browser.document.body.querySelector("#client")
	);
}

/////////////////////////////////////////////////////////////////////

class Router implements Mithril
{
	final asset : Asset;

	public function new(asset, element) {
		this.asset = asset;

		M.route(element, "/", {
			"/": {
				render: _ -> {
					trace("New EventList");
					layout(new EventList(asset.state.events));
				}
			}
		});
	}

	function layout(view : Component) 
		m('.flex-vertical.flex-center', m('.container', [
			m('header.flex-center', m('img[src=logo.png]#logo')),
			m(view)
		]));
}

/////////////////////////////////////////////////////////////////////

private class EventList implements Mithril
{
	final events : ImmutableArray<Event>;

	public function new(events) {
		var events : Array<Dynamic> = [
			{
				"created": 1547737367000,
				"duration": 7200000,
				"id": "258157165",
				"name": "Full stack at its finest - Cutting through the web jungle with Haxe!",
				"status": "upcoming",
				"time": 1549389600000,
				"local_date": "2019-02-05",
				"local_time": "19:00",
				"updated": 1547737367000,
				"utc_offset": 3600000,
				"waitlist_count": 0,
				"yes_rsvp_count": 4,
				"group": {
					"created": 1495742331000,
					"name": "Örnsköldsvik Developer Meetup",
					"id": 24015849,
					"join_mode": "open",
					"lat": 63.29999923706055,
					"lon": 18.719999313354492,
					"urlname": "ovik-dev",
					"who": "Members",
					"localized_location": "Örnsköldsvik, Sweden",
					"state": "",
					"country": "se",
					"region": "en_US",
					"timezone": "Europe/Stockholm"
				},
				"link": "https://www.meetup.com/ovik-dev/events/258157165/",
				"description": "<p>The modern cross-platform language Haxe has many features that can simplify the tool set of many projects. This meetup we will create a landing page for the meetup group, using Haxe to compile and share code between server and client, and showcasing what makes Haxe such an elegant, powerful language!</p> ",
				"visibility": "public"
			},
			{
				"created": 1526022205000,
				"duration": 5400000,
				"id": "250678954",
				"name": "TypeScript - build JavaScript apps with greater confidence and speed",
				"rsvp_limit": 30,
				"status": "past",
				"time": 1544612400000,
				"local_date": "2018-12-12",
				"local_time": "12:00",
				"updated": 1544622160000,
				"utc_offset": 3600000,
				"waitlist_count": 0,
				"yes_rsvp_count": 5,
				"venue": {
					"id": 25266000,
					"name": "BizMaker",
					"lat": 63.28859329223633,
					"lon": 18.71357536315918,
					"repinned": true,
					"address_1": "Lasarettsgatan 5",
					"city": "Örnsköldsvik",
					"country": "se",
					"localized_country_name": "Sweden"
				},
				"group": {
					"created": 1495742331000,
					"name": "Örnsköldsvik Developer Meetup",
					"id": 24015849,
					"join_mode": "open",
					"lat": 63.29999923706055,
					"lon": 18.719999313354492,
					"urlname": "ovik-dev",
					"who": "Members",
					"localized_location": "Örnsköldsvik, Sweden",
					"state": "",
					"country": "se",
					"region": "en_US",
					"timezone": "Europe/Stockholm"
				},
				"link": "https://www.meetup.com/ovik-dev/events/250678954/",
				"description": "<p>• What we'll do<br/>What is TypeScript? We'll answer that and also how you can leverage a type system in JavaScript to make your development speed go up and the confidence you have in your code as well.</p> <p>Due to lack of RSVPs we've moved this to be a lunch meetup in hopes it will be possible for more people to attend.</p> <p>Psst! Here you'll find links and other goodies: <a href=\"https://jrbaudin.github.io/odm-awesome-list/\" class=\"linkified\">https://jrbaudin.github.io/odm-awesome-list/</a></p> ",
				"how_to_find_us": "Follow the signs directing you to the meetup",
				"visibility": "public"
			},
			{
				"created": 1525944536000,
				"duration": 7200000,
				"id": "250645375",
				"name": "How to create and maintain a Design System and why you should do it",
				"rsvp_limit": 30,
				"status": "past",
				"time": 1543428000000,
				"local_date": "2018-11-28",
				"local_time": "19:00",
				"updated": 1543442432000,
				"utc_offset": 3600000,
				"waitlist_count": 0,
				"yes_rsvp_count": 2,
				"venue": {
					"id": 25266000,
					"name": "BizMaker",
					"lat": 63.28859329223633,
					"lon": 18.71357536315918,
					"repinned": true,
					"address_1": "Lasarettsgatan 5",
					"city": "Örnsköldsvik",
					"country": "se",
					"localized_country_name": "Sweden"
				},
				"group": {
					"created": 1495742331000,
					"name": "Örnsköldsvik Developer Meetup",
					"id": 24015849,
					"join_mode": "open",
					"lat": 63.29999923706055,
					"lon": 18.719999313354492,
					"urlname": "ovik-dev",
					"who": "Members",
					"localized_location": "Örnsköldsvik, Sweden",
					"state": "",
					"country": "se",
					"region": "en_US",
					"timezone": "Europe/Stockholm"
				},
				"link": "https://www.meetup.com/ovik-dev/events/250645375/",
				"description": "<p>• What we'll do<br/>How to create and maintain a Design System and why you should do it.</p> <p>More info to come...</p> <p>Psst! Here you'll find links and other goodies: <a href=\"https://jrbaudin.github.io/odm-awesome-list/\" class=\"linkified\">https://jrbaudin.github.io/odm-awesome-list/</a></p> ",
				"how_to_find_us": "Follow the signs directing you to the meetup.\n\nCan enter at Lasarettsgatan 3 also then two stairs up.",
				"visibility": "public"
			},
			{
				"created": 1525943999000,
				"duration": 7200000,
				"id": "250645179",
				"name": "Node.js 101 and how to actually deploy it - Docker, Kubernetes, DigitalOcean etc",
				"rsvp_limit": 30,
				"status": "past",
				"time": 1541008800000,
				"local_date": "2018-10-31",
				"local_time": "19:00",
				"updated": 1541021915000,
				"utc_offset": 3600000,
				"waitlist_count": 0,
				"yes_rsvp_count": 5,
				"venue": {
					"id": 25266000,
					"name": "BizMaker",
					"lat": 63.28859329223633,
					"lon": 18.71357536315918,
					"repinned": true,
					"address_1": "Lasarettsgatan 5",
					"city": "Örnsköldsvik",
					"country": "se",
					"localized_country_name": "Sweden"
				},
				"group": {
					"created": 1495742331000,
					"name": "Örnsköldsvik Developer Meetup",
					"id": 24015849,
					"join_mode": "open",
					"lat": 63.29999923706055,
					"lon": 18.719999313354492,
					"urlname": "ovik-dev",
					"who": "Members",
					"localized_location": "Örnsköldsvik, Sweden",
					"state": "",
					"country": "se",
					"region": "en_US",
					"timezone": "Europe/Stockholm"
				},
				"link": "https://www.meetup.com/ovik-dev/events/250645179/",
				"description": "<p>• What we'll do<br/>The crash course in Node.js and how to effectively deploy it. Docker and all the other goodies.</p> <p>More info to come...</p> <p>Psst! Here you'll find links and other goodies: <a href=\"https://jrbaudin.github.io/odm-awesome-list/\" class=\"linkified\">https://jrbaudin.github.io/odm-awesome-list/</a></p> ",
				"how_to_find_us": "Follow the signs directing you to the meetup",
				"visibility": "public"
			},
			{
				"created": 1525942854000,
				"duration": 3600000,
				"id": "250645033",
				"name": "How to run a GraphQL server using Apollo",
				"rsvp_limit": 30,
				"status": "past",
				"time": 1530093600000,
				"local_date": "2018-06-27",
				"local_time": "12:00",
				"updated": 1530100883000,
				"utc_offset": 7200000,
				"waitlist_count": 0,
				"yes_rsvp_count": 6,
				"venue": {
					"id": 25266000,
					"name": "BizMaker",
					"lat": 63.28859329223633,
					"lon": 18.71357536315918,
					"repinned": false,
					"address_1": "Lasarettsgatan 5",
					"city": "Örnsköldsvik",
					"country": "se",
					"localized_country_name": "Sweden"
				},
				"group": {
					"created": 1495742331000,
					"name": "Örnsköldsvik Developer Meetup",
					"id": 24015849,
					"join_mode": "open",
					"lat": 63.29999923706055,
					"lon": 18.719999313354492,
					"urlname": "ovik-dev",
					"who": "Members",
					"localized_location": "Örnsköldsvik, Sweden",
					"state": "",
					"country": "se",
					"region": "en_US",
					"timezone": "Europe/Stockholm"
				},
				"link": "https://www.meetup.com/ovik-dev/events/250645033/",
				"description": "<p>• What we'll do<br/>Learn how to actually run a GraphQL server using Apollo.</p> <p>More info to come...</p> <p>Psst! Here you'll find links and other goodies: <a href=\"https://jrbaudin.github.io/odm-awesome-list/\" class=\"linkified\">https://jrbaudin.github.io/odm-awesome-list/</a></p> ",
				"how_to_find_us": "Follow the signs directing you to the meetup",
				"visibility": "public"
			},
			{
				"created": 1525942569000,
				"duration": 7200000,
				"id": "250644997",
				"name": "Vue.js - An introduction to \"The Progressive JavaScript Framework\"",
				"rsvp_limit": 30,
				"status": "past",
				"time": 1527613200000,
				"local_date": "2018-05-29",
				"local_time": "19:00",
				"updated": 1527628100000,
				"utc_offset": 7200000,
				"waitlist_count": 0,
				"yes_rsvp_count": 4,
				"venue": {
					"id": 25266000,
					"name": "BizMaker",
					"lat": 63.28859329223633,
					"lon": 18.71357536315918,
					"repinned": false,
					"address_1": "Lasarettsgatan 5",
					"city": "Örnsköldsvik",
					"country": "se",
					"localized_country_name": "Sweden"
				},
				"group": {
					"created": 1495742331000,
					"name": "Örnsköldsvik Developer Meetup",
					"id": 24015849,
					"join_mode": "open",
					"lat": 63.29999923706055,
					"lon": 18.719999313354492,
					"urlname": "ovik-dev",
					"who": "Members",
					"localized_location": "Örnsköldsvik, Sweden",
					"state": "",
					"country": "se",
					"region": "en_US",
					"timezone": "Europe/Stockholm"
				},
				"link": "https://www.meetup.com/ovik-dev/events/250644997/",
				"description": "<p>NOTE: Day changed to Tuesday!</p> <p>• What we'll do<br/>Get an introduction to the \"new\" kid on the block when it comes to Javascript frontend frameworks, Vue.js.</p> <p>More info to come...</p> <p>Psst! Here you'll find links and other goodies: <a href=\"https://jrbaudin.github.io/odm-awesome-list/\" class=\"linkified\">https://jrbaudin.github.io/odm-awesome-list/</a></p> ",
				"how_to_find_us": "Follow the signs directing you to the meetup",
				"visibility": "public"
			},
			{
				"created": 1525636508000,
				"duration": 7200000,
				"id": "250521673",
				"name": "Hang out with ODM AW!",
				"status": "past",
				"time": 1525885200000,
				"local_date": "2018-05-09",
				"local_time": "19:00",
				"updated": 1525905083000,
				"utc_offset": 7200000,
				"waitlist_count": 0,
				"yes_rsvp_count": 2,
				"venue": {
					"id": 25824641,
					"name": "Espresso House",
					"lat": 63.288665771484375,
					"lon": 18.716684341430664,
					"repinned": false,
					"address_1": "Storgatan 12b",
					"city": "Örnsköldsvik",
					"country": "se",
					"localized_country_name": "Sweden"
				},
				"group": {
					"created": 1495742331000,
					"name": "Örnsköldsvik Developer Meetup",
					"id": 24015849,
					"join_mode": "open",
					"lat": 63.29999923706055,
					"lon": 18.719999313354492,
					"urlname": "ovik-dev",
					"who": "Members",
					"localized_location": "Örnsköldsvik, Sweden",
					"state": "",
					"country": "se",
					"region": "en_US",
					"timezone": "Europe/Stockholm"
				},
				"link": "https://www.meetup.com/ovik-dev/events/250521673/",
				"description": "<p>Simple after work with ODM. Come and just hang out!</p> ",
				"how_to_find_us": "Find the biggest coffe cup with a apple at the side :)",
				"visibility": "public"
			},
			{
				"created": 1517857346000,
				"duration": 7200000,
				"id": "247518466",
				"name": "Using Atomic Design to build interfaces!",
				"status": "past",
				"time": 1519840800000,
				"local_date": "2018-02-28",
				"local_time": "19:00",
				"updated": 1519904028000,
				"utc_offset": 3600000,
				"waitlist_count": 0,
				"yes_rsvp_count": 6,
				"venue": {
					"id": 25266000,
					"name": "BizMaker",
					"lat": 63.28859329223633,
					"lon": 18.71357536315918,
					"repinned": false,
					"address_1": "Lasarettsgatan 5",
					"city": "Örnsköldsvik",
					"country": "se",
					"localized_country_name": "Sweden"
				},
				"group": {
					"created": 1495742331000,
					"name": "Örnsköldsvik Developer Meetup",
					"id": 24015849,
					"join_mode": "open",
					"lat": 63.29999923706055,
					"lon": 18.719999313354492,
					"urlname": "ovik-dev",
					"who": "Members",
					"localized_location": "Örnsköldsvik, Sweden",
					"state": "",
					"country": "se",
					"region": "en_US",
					"timezone": "Europe/Stockholm"
				},
				"link": "https://www.meetup.com/ovik-dev/events/247518466/",
				"description": "<p>• What we'll do<br/>\"We’re not designing pages, we’re designing systems of components.\" - Stephen Hay</p> <p>\"Interfaces are made up of smaller components. This means we can break entire interfaces down into fundamental building blocks and work up from there. That’s the basic gist of atomic design.\" -<br/>Brad Frost</p> <p>Will try and get you into the mindset of thinking in atomics when building and designing interfaces.</p> <p>Find more info @ <a href=\"https://jrbaudin.github.io/odm-awesome-list/\" class=\"linkified\">https://jrbaudin.github.io/odm-awesome-list/</a></p> <p>• What to bring</p> <p>• Important to know</p> ",
				"visibility": "public"
			},
			{
				"created": 1517381945000,
				"duration": 7200000,
				"id": "247340286",
				"name": "From Zero to App with React Native",
				"rsvp_limit": 20,
				"status": "past",
				"time": 1518544800000,
				"local_date": "2018-02-13",
				"local_time": "19:00",
				"updated": 1518557797000,
				"utc_offset": 3600000,
				"waitlist_count": 0,
				"yes_rsvp_count": 8,
				"venue": {
					"id": 25266000,
					"name": "BizMaker",
					"lat": 63.28859329223633,
					"lon": 18.71357536315918,
					"repinned": false,
					"address_1": "Lasarettsgatan 5",
					"city": "Örnsköldsvik",
					"country": "se",
					"localized_country_name": "Sweden"
				},
				"group": {
					"created": 1495742331000,
					"name": "Örnsköldsvik Developer Meetup",
					"id": 24015849,
					"join_mode": "open",
					"lat": 63.29999923706055,
					"lon": 18.719999313354492,
					"urlname": "ovik-dev",
					"who": "Members",
					"localized_location": "Örnsköldsvik, Sweden",
					"state": "",
					"country": "se",
					"region": "en_US",
					"timezone": "Europe/Stockholm"
				},
				"link": "https://www.meetup.com/ovik-dev/events/247340286/",
				"manual_attendance_count": 8,
				"description": "<p>• What we'll do<br/>Welcome to Övik Devs first meetup of the new year!</p> <p>This time we'll go from Zero to App using React Native. We'll live code the app starting with a blank page and end up installing an APK (file format for apps packaged for Android) on a physical Android device.</p> <p>No previous knowledge of app development nor React Native is needed.</p> <p>If you have any questions regarding this kind of development prepare them in advance and bring them up during the meetup!</p> <p>We'll see you there!</p> <p>Psst! Here you'll find links and other goodies: <a href=\"https://jrbaudin.github.io/odm-awesome-list/\" class=\"linkified\">https://jrbaudin.github.io/odm-awesome-list/</a></p> ",
				"how_to_find_us": "Follow the signs directing you to the meetup",
				"visibility": "public"
			},
			{
				"created": 1507711186000,
				"duration": 7200000,
				"id": "244107581",
				"name": "DCI - How to get ahead in system architecture",
				"status": "past",
				"time": 1510768800000,
				"local_date": "2017-11-15",
				"local_time": "19:00",
				"updated": 1510827674000,
				"utc_offset": 3600000,
				"waitlist_count": 0,
				"yes_rsvp_count": 16,
				"venue": {
					"id": 25332134,
					"name": "Clavister",
					"lat": 63.280517578125,
					"lon": 18.73722267150879,
					"repinned": false,
					"address_1": "Sjögatan 6J",
					"city": "Örnsköldsvik",
					"country": "se",
					"localized_country_name": "Sweden"
				},
				"group": {
					"created": 1495742331000,
					"name": "Örnsköldsvik Developer Meetup",
					"id": 24015849,
					"join_mode": "open",
					"lat": 63.29999923706055,
					"lon": 18.719999313354492,
					"urlname": "ovik-dev",
					"who": "Members",
					"localized_location": "Örnsköldsvik, Sweden",
					"state": "",
					"country": "se",
					"region": "en_US",
					"timezone": "Europe/Stockholm"
				},
				"link": "https://www.meetup.com/ovik-dev/events/244107581/",
				"description": "<p>Welcome to ÖDM's next meetup!</p> <p>This time Andreas Söderlund (<a href=\"https://github.com/ciscoheat\" class=\"linkified\">https://github.com/ciscoheat</a>) will talk about DCI</p> <p>DCI stands for Data, Context, Interaction. The key aspects of the DCI architecture are:</p> <p>• Separating what the system is (data) from what it does (function). Data and function have different rates of change so they should be separated, not as it currently is, put in classes together.</p> <p>• Create a direct mapping from the user's mental model to code. The computer should think as the user, not the other way around.</p> <p>• Make system behavior a first class entity.</p> <p>• Great code readability with no surprises at runtime.</p> <p>The host for this meetup is: Clavister.</p> <p>Material for this meetup (and previous meetups)<br/>— </p> <p>On this page <a href=\"https://jrbaudin.github.io/odm-awesome-list we\" class=\"linkified\">https://jrbaudin.github.io/odm-awesome-list we</a> collect all relevant information for these meetups. For example Demo-repos, presentations, links, etc.</p> <p>Book Wednesday the 15th of november in your calendar and we'll see you there!</p> <p>Questions, thoughts and discussions can easily be had here on meetup.com (<a href=\"https://www.meetup.com/ovik-dev/\" class=\"linkified\">https://www.meetup.com/ovik-dev/</a>) or on the Facebook page (<a href=\"https://www.facebook.com/groups/117816668796460\" class=\"linkified\">https://www.facebook.com/groups/117816668796460</a>).</p> <p>More information regarding this meetup will come!</p> <p>PS. Remember to join our group on Slack by requesting an invite here: <a href=\"https://ovikdevmeetup.now.sh/\"><a href=\"https://ovikdevmeetup.now.sh\" class=\"linkified\">https://ovikdevmeetup.now.sh</a></a></p> ",
				"how_to_find_us": "Search for notes with ”ÖDM Meetup” written on them that will send you in the right direction",
				"visibility": "public"
			},
			{
				"created": 1505770145000,
				"duration": 7200000,
				"id": "243474171",
				"name": "Introduktion till GraphQL",
				"status": "past",
				"time": 1507654800000,
				"local_date": "2017-10-10",
				"local_time": "19:00",
				"updated": 1507795784000,
				"utc_offset": 7200000,
				"waitlist_count": 0,
				"yes_rsvp_count": 10,
				"venue": {
					"id": 25266000,
					"name": "BizMaker",
					"lat": 63.28859329223633,
					"lon": 18.71357536315918,
					"repinned": false,
					"address_1": "Lasarettsgatan 5",
					"city": "Örnsköldsvik",
					"country": "se",
					"localized_country_name": "Sweden"
				},
				"group": {
					"created": 1495742331000,
					"name": "Örnsköldsvik Developer Meetup",
					"id": 24015849,
					"join_mode": "open",
					"lat": 63.29999923706055,
					"lon": 18.719999313354492,
					"urlname": "ovik-dev",
					"who": "Members",
					"localized_location": "Örnsköldsvik, Sweden",
					"state": "",
					"country": "se",
					"region": "en_US",
					"timezone": "Europe/Stockholm"
				},
				"link": "https://www.meetup.com/ovik-dev/events/243474171/",
				"description": "<p>Välkommen på ÖDM's tredje meetup!<br/>Introduktion till GraphQL</p> <p>Värd för denna träff: BizMaker.</p> <p>Johan Lindgren (<a href=\"https://github.com/lindgr3n\" class=\"linkified\">https://github.com/lindgr3n</a>) och Joel Baudin (<a href=\"https://github.com/jrbaudin\" class=\"linkified\">https://github.com/jrbaudin</a>) kommer under denna träff prata om GraphQL (<a href=\"http://graphql.org/learn/\" class=\"linkified\">http://graphql.org/learn/</a>) och hur det fungerar.</p> <p>Material för denna träff (och tidigare meetups)<br/>—\u0000<br/>På denna sida (<a href=\"https://jrbaudin.github.io/odm-awesome-list/\" class=\"linkified\">https://jrbaudin.github.io/odm-awesome-list/</a>) samlar vi all relevant information för dessa träffar. T.ex. Demo-repos, presentationer, länkar, osv.</p> <p>Boka tisdag 10 oktober i kalendern så ses vi!</p> <p>Frågor, funderingar och diskussion kan med fördel tas här på meetup (<a href=\"https://www.meetup.com/ovik-dev/\" class=\"linkified\">https://www.meetup.com/ovik-dev/</a>) eller på facebook-sidan (<a href=\"https://www.facebook.com/groups/117816668796460\" class=\"linkified\">https://www.facebook.com/groups/117816668796460</a>).</p> <p>Mer information kring denna träff kommer!</p> ",
				"how_to_find_us": "Sök efter lappar med ”ÖDM” och pilar som skickar dig rätt",
				"visibility": "public"
			},
			{
				"created": 1498631798000,
				"id": "241137933",
				"name": "Testning i Javascript med Jest",
				"status": "past",
				"time": 1502298000000,
				"local_date": "2017-08-09",
				"local_time": "19:00",
				"updated": 1502782821000,
				"utc_offset": 7200000,
				"waitlist_count": 0,
				"yes_rsvp_count": 8,
				"venue": {
					"id": 25332134,
					"name": "Clavister",
					"lat": 63.280517578125,
					"lon": 18.73722267150879,
					"repinned": false,
					"address_1": "Sjögatan 6J",
					"city": "Örnsköldsvik",
					"country": "se",
					"localized_country_name": "Sweden"
				},
				"group": {
					"created": 1495742331000,
					"name": "Örnsköldsvik Developer Meetup",
					"id": 24015849,
					"join_mode": "open",
					"lat": 63.29999923706055,
					"lon": 18.719999313354492,
					"urlname": "ovik-dev",
					"who": "Members",
					"localized_location": "Örnsköldsvik, Sweden",
					"state": "",
					"country": "se",
					"region": "en_US",
					"timezone": "Europe/Stockholm"
				},
				"link": "https://www.meetup.com/ovik-dev/events/241137933/",
				"description": "<p><img src=\"https://secure.meetupstatic.com/photos/event/d/4/b/7/600_462354455.jpeg\" /></p> <p><b>Välkommen på ÖDM's andra meetup!<br/>--&gt; Testning i Javascript med Jest</b></p> <p>Värd för denna träff är <a href=\"https://www.clavister.com/\">Clavister</a> (Tack!)</p> <p><a href=\"https://github.com/lindgr3n\">Johan Lindgren</a> kommer under denna träff prata om <a href=\"https://egghead.io/lessons/javascript-test-javascript-with-jest\">Testning i Javascript</a> med hjälp av <a href=\"https://facebook.github.io/jest/\">Jest</a></p> <p><b>Material för denna träff (och tidigare meetups)</b><br/>På <a href=\"https://jrbaudin.github.io/odm-awesome-list/\">denna sida</a> samlar vi all relevant information för dessa träffar. T.ex. Demo-repos, presentationer, länkar, osv.</p> <p>Boka onsdag 9 augusti i kalendern så ses vi! </p> <p>Frågor, funderingar och diskussion kan med fördel tas <a href=\"https://www.meetup.com/ovik-dev/\">här på meetup</a> eller på <a href=\"https://www.facebook.com/groups/117816668796460\">facebook-sidan</a></p> <p>Mer information kring denna träff kommer! </p> ",
				"how_to_find_us": "Hitta till Clavisters lokaler och därefter lappar/skyltar som leder dig rätt",
				"visibility": "public"
			},
			{
				"created": 1495780017000,
				"duration": 7200000,
				"id": "240287936",
				"name": "Kom igång snabbt med React och Firebase",
				"rsvp_limit": 20,
				"status": "past",
				"time": 1497459600000,
				"local_date": "2017-06-14",
				"local_time": "19:00",
				"updated": 1497692399000,
				"utc_offset": 7200000,
				"waitlist_count": 0,
				"yes_rsvp_count": 9,
				"venue": {
					"id": 25266000,
					"name": "BizMaker",
					"lat": 63.28859329223633,
					"lon": 18.71357536315918,
					"repinned": false,
					"address_1": "Lasarettsgatan 5",
					"city": "Örnsköldsvik",
					"country": "se",
					"localized_country_name": "Sweden"
				},
				"group": {
					"created": 1495742331000,
					"name": "Örnsköldsvik Developer Meetup",
					"id": 24015849,
					"join_mode": "open",
					"lat": 63.29999923706055,
					"lon": 18.719999313354492,
					"urlname": "ovik-dev",
					"who": "Members",
					"localized_location": "Örnsköldsvik, Sweden",
					"state": "",
					"country": "se",
					"region": "en_US",
					"timezone": "Europe/Stockholm"
				},
				"link": "https://www.meetup.com/ovik-dev/events/240287936/",
				"description": "<p><img src=\"https://secure.meetupstatic.com/photos/event/9/b/4/1/600_461319745.jpeg\" /></p> <p>React &amp; Firebase</p> <p>Välkommen till första träffen med Övik Developer Meetup! Vi kommer den här gången gå igenom hur man kan använda React och Firebase för att snabbt komma igång med en webb-applikation. </p> <p>Värd för denna första träff är <a href=\"http://www.bizmaker.se\">BizMaker</a>!</p> <p><b>Hur man hittar rätt</b><br/>Enklast är att ta ingången från Lasarettsgatan som är nedanför (närmre hamnen) vanliga ingången till Biblioteket, Café Lara osv. Där tar du <b>hissen</b> och klickar på våning <b>5</b>. När du kommer ut ur hissen kollar du till höger och då bör du se dörren till BizMaker och kan ringa dörrklockan. Vi kommer också få upp lite lappar som förhoppningsvis kan leda rätt. Annars är det bara att höra av sig på 070 566 64 21.</p> <p>Mer information kommer!</p> ",
				"visibility": "public"
			}
		];

		this.events = cast events;
	}

	public function view() cast [
		events.filter(e -> e.status == Upcoming).map(eventView),
		cast m('h2', 'Past meetups'),
		events.filter(e -> e.status == Past).map(eventView)
	];

	function eventView(e : Event)
		m('article', [
			m('time', Date.fromTime(e.time).format("%Y-%m-%d")),
			m('h2', e.name),
			m('a', {href: e.link, target: "_blank"}, "RSVP here")
		]);
}
