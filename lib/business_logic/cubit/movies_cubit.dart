import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_app/data/models/movie.dart';
import 'package:tv_app/data/models/movie_details.dart';
import 'package:tv_app/data/models/popular_movies.dart';
import 'package:tv_app/data/repository/movies_repository.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {

  final MoviesRepository moviesRepository;
  PopularMovies? popularMovies;
  int currentPage = 1;
  bool isLoading = false;
  List<Movie> movies = [];
  MovieDetails? movieDetails;

  MoviesCubit(this.moviesRepository) : super(MoviesInitial());

  void getPopularMovies() {
    if (isLoading) return;

    isLoading = true;
    moviesRepository.getPopularMovies(currentPage).then((popularMovies) {
      currentPage++;
      // Take From Repository And Send To The UI
      movies.addAll(popularMovies.movie);
      emit(PopularMoviesLoaded(movies));
      isLoading = false;
    });
  }

  void getMovieDetails(int id) {
    moviesRepository.getMovieDetails(id).then((movieDetails) {
      // Take From Repository And Send To The UI
      emit(MovieDetailsLoaded(movieDetails));
    });
  }
}
