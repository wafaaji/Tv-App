import 'dart:convert';
import 'package:tv_app/data/models/movie.dart';

PopularMovies popularMoviesFromJson(String str) => PopularMovies.fromJson(json.decode(str));

String popularMoviesToJson(PopularMovies data) => json.encode(data.toJson());

class PopularMovies {
  int page;
  List<Movie> movie;
  int totalPages;
  int totalResults;

  PopularMovies({
    required this.page,
    required this.movie,
    required this.totalPages,
    required this.totalResults,
  });

  factory PopularMovies.fromJson(Map<String, dynamic> json) => PopularMovies(
    page: json["page"],
    movie: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(movie.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}