class Series{
  int id;
  String originalLanguage;
  String originalName;
  String overview;
  String posterPath;
  String firstAirDate;
  String name;
  double voteAverage;
  int voteCount;

  Series({
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  String getPosterUrl() {
    const String baseUrl = "https://image.tmdb.org/t/p/w500";
    if (posterPath.isNotEmpty) {
      return "$baseUrl$posterPath";
    }
    print("Poster path is empty"); // Debugging line
    return ''; // Return an empty string if posterPath is empty
  }

  factory Series.fromJson(Map<String, dynamic> json) => Series(
    id: json["id"],
    originalLanguage: json["original_language"],
    originalName: json["original_name"],
    overview: json["overview"],
    posterPath: json["poster_path"] ?? '',
    firstAirDate: json["first_air_date"],
    name: json["name"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "poster_path": posterPath,
    "first_air_date": firstAirDate,
    "name": name,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}