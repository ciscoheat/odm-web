
@:enum abstract EventStatus(String) from String {
    var Upcoming = "upcoming";
    var Past = "past";
}

typedef Event = {
    final id : String;
    final time : Float;
    final link : String;
    final name : String;
    final status : EventStatus;
}
