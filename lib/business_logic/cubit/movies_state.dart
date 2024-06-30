part of 'movies_cubit.dart';

abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

// When there is error
// class PopularMoviesErrorCase extends MoviesState {
//
// }

// When the popular movies loaded
class PopularMoviesLoaded extends MoviesState {
  final List<Movie> movies;

  PopularMoviesLoaded(this.movies);
}

// When the movies details loaded
class MovieDetailsLoaded extends MoviesState {
  final MovieDetails movieDetails;

  MovieDetailsLoaded(this.movieDetails);
}