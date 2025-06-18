class Activity {
  final String activity;
  final double availability;
  final String type;
  final int participants;
  final double price;
  final String accessibility;
  final String duration;
  final bool kidFriendly;
  final String link;
  final String key;

  Activity({
    required this.activity,
    required this.availability,
    required this.type,
    required this.participants,
    required this.price,
    required this.accessibility,
    required this.duration,
    required this.kidFriendly,
    required this.link,
    required this.key,
  });

  @override
  String toString() {
    return '''
Activity {
  activity: $activity,
  availability: $availability,
  type: $type,
  participants: $participants,
  price: $price,
  accessibility: $accessibility,
  duration: $duration,
  kidFriendly: $kidFriendly,
  link: $link,
  key: $key
}''';
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      activity: json['activity'],
      availability: json['availability']?.toDouble() ?? 0.0,
      type: json['type'],
      participants: json['participants'],
      price: json['price']?.toDouble() ?? 0.0,
      accessibility: json['accessibility'],
      duration: json['duration'],
      kidFriendly: json['kidFriendly'],
      link: json['link'] ?? "No Link Available",
      key: json['key'],
    );
  }
}
