class Movie {
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  String title;
  double voteAverage;
  int voteCount;

  Movie({
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  String getPosterUrl() {
    const String baseUrl = "https://image.tmdb.org/t/p/w500";
    if (posterPath.isNotEmpty) {
      return "$baseUrl$posterPath";
    }
    return ''; // Return an empty string if posterPath is empty
  }

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json["id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    posterPath: json["poster_path"] ?? '',
    releaseDate: json["release_date"],
    title: json["title"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "poster_path": posterPath,
    "release_date": releaseDate,
    "title": title,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}