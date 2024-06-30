import 'package:tv_app/data/models/popular_movies.dart';
import 'package:tv_app/data/web_services/movies_web_services.dart';
import 'package:tv_app/data/models/movie_details.dart';

class MoviesRepository{

  // WebServices Object
  final MoviesWebServices moviesWebServices;

  MoviesRepository(this.moviesWebServices);

  Future<PopularMovies> getPopularMovies(int page) async{
    final popularMovies = await moviesWebServices.getPopularMovies(page);
    return popularMovies;
  }

  Future<MovieDetails> getMovieDetails(int id) async{
    final movieDetails = await moviesWebServices.getMovieDetails(id);
    return movieDetails;
  }
}