import 'package:dio/dio.dart';
import 'package:tv_app/constants/strings.dart';
import 'package:tv_app/data/models/popular_movies.dart';
import 'package:tv_app/data/models/movie_details.dart';

class MoviesWebServices {
  late Dio dio;

  MoviesWebServices(){
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 20), // 20 seconds
      receiveTimeout: Duration(seconds: 20), // 20 seconds
    );
    dio = Dio(options);
  }

  Future<PopularMovies> getPopularMovies(int page) async {
    try {
      Response response = await dio.get("/movie/popular?api_key=$apiKey&page=$page");
      print(response.data.toString());
      return PopularMovies.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load popular movies');
    }
  }

  Future<MovieDetails> getMovieDetails(int id) async {
    try {
      Response response = await dio.get("/movie/$id?api_key=$apiKey");
      print(response.data.toString());
      return MovieDetails.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load movie details');
    }
  }
}