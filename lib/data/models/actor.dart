class Actor {
  int gender;
  int id;
  String name;
  String originalName;
  String profilePath;
  List<KnownFor> knownFor;

  Actor({
    required this.gender,
    required this.id,
    required this.name,
    required this.originalName,
    required this.profilePath,
    required this.knownFor,
  });

  String getProfileUrl() {
    const String baseUrl = "https://image.tmdb.org/t/p/w500";
    if (profilePath.isNotEmpty) {
      return "$baseUrl$profilePath";
    }
    return ''; // Return an empty string if posterPath is empty
  }

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
    gender: json["gender"],
    id: json["id"],
    name: json["name"],
    originalName: json["original_name"],
    profilePath: json["profile_path"],
    knownFor: List<KnownFor>.from(json["known_for"].map((x) => KnownFor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "gender": gender,
    "id": id,
    "name": name,
    "original_name": originalName,
    "profile_path": profilePath,
    "known_for": List<dynamic>.from(knownFor.map((x) => x.toJson())),
  };
}

class KnownFor {
  int id;
  String? title;

  KnownFor({
    required this.id,
    this.title,
  });

  factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}