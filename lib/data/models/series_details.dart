import 'dart:convert';

SeriesDetails seriesDetailsFromJson(String str) => SeriesDetails.fromJson(json.decode(str));

String seriesDetailsToJson(SeriesDetails data) => json.encode(data.toJson());

class SeriesDetails {
  List<Genre> genres;
  int id;
  String lastAirDate;
  int numberOfEpisodes;
  int numberOfSeasons;
  List<ProductionCompany> productionCompanies;
  String status;
  String tagline;
  String type;

  SeriesDetails({
    required this.genres,
    required this.id,
    required this.lastAirDate,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.productionCompanies,
    required this.status,
    required this.tagline,
    required this.type,
  });

  factory SeriesDetails.fromJson(Map<String, dynamic> json) => SeriesDetails(
    genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
    id: json["id"],
    lastAirDate: json["last_air_date"],
    numberOfEpisodes: json["number_of_episodes"],
    numberOfSeasons: json["number_of_seasons"],
    productionCompanies: List<ProductionCompany>.from(json["production_companies"].map((x) => ProductionCompany.fromJson(x))),
    status: json["status"],
    tagline: json["tagline"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "id": id,
    "last_air_date": lastAirDate,
    "number_of_episodes": numberOfEpisodes,
    "number_of_seasons": numberOfSeasons,
    "production_companies": List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
    "status": status,
    "tagline": tagline,
    "type": type,
  };
}

class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class ProductionCompany {
  int id;
  String name;

  ProductionCompany({
    required this.id,
    required this.name,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) => ProductionCompany(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
