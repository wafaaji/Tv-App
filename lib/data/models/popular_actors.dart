import 'dart:convert';

import 'package:tv_app/data/models/actor.dart';

PopularActors popularActorFromJson(String str) => PopularActors.fromJson(json.decode(str));

String popularActorToJson(PopularActors data) => json.encode(data.toJson());

class PopularActors {
  int page;
  List<Actor> actor;
  int totalPages;
  int totalResults;

  PopularActors({
    required this.page,
    required this.actor,
    required this.totalPages,
    required this.totalResults,
  });

  factory PopularActors.fromJson(Map<String, dynamic> json) => PopularActors(
    page: json["page"],
    actor: List<Actor>.from(json["results"].map((x) => Actor.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(actor.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}