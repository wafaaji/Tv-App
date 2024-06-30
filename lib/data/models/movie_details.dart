import 'dart:convert';

MovieDetails movieDetailsFromJson(String str) => MovieDetails.fromJson(json.decode(str));

String movieDetailsToJson(MovieDetails data) => json.encode(data.toJson());

class MovieDetails {
  int budget;
  List<Genre> genres;
  int id;
  List<ProductionCompany> productionCompanies;
  int revenue;
  int runtime;
  String status;
  String tagline;

  MovieDetails({
    required this.budget,
    required this.genres,
    required this.id,
    required this.productionCompanies,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
    budget: json["budget"],
    genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
    id: json["id"],
    productionCompanies: List<ProductionCompany>.from(json["production_companies"].map((x) => ProductionCompany.fromJson(x))),
    revenue: json["revenue"],
    runtime: json["runtime"],
    status: json["status"],
    tagline: json["tagline"],
  );

  Map<String, dynamic> toJson() => {
    "budget": budget,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "id": id,
    "production_companies": List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
    "revenue": revenue,
    "runtime": runtime,
    "status": status,
    "tagline": tagline,
  };
}

class Genre {
  String name;

  Genre({
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class ProductionCompany {
  String name;

  ProductionCompany({
    required this.name,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) => ProductionCompany(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}