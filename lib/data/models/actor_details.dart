import 'dart:convert';

ActorDetails actorDetailsFromJson(String str) => ActorDetails.fromJson(json.decode(str));

String actorDetailsToJson(ActorDetails data) => json.encode(data.toJson());

class ActorDetails {
  String? birthday;
  String? deathday;
  int id;
  String? placeOfBirth;

  ActorDetails({
    required this.birthday,
    required this.deathday,
    required this.id,
    required this.placeOfBirth,
  });

  factory ActorDetails.fromJson(Map<String, dynamic> json) => ActorDetails(
    birthday: json["birthday"] ?? "",
    deathday: json["deathday"] ?? "",
    id: json["id"],
    placeOfBirth: json["place_of_birth"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "birthday": birthday,
    "deathday": deathday,
    "id": id,
    "place_of_birth": placeOfBirth,
  };
}
