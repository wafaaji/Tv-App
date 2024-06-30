import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_app/business_logic/cubit/actors_cubit.dart';
import 'package:tv_app/business_logic/cubit/movies_cubit.dart';
import 'package:tv_app/business_logic/cubit/series_cubit.dart';
import 'package:tv_app/constants/strings.dart';
import 'package:tv_app/data/models/actor.dart';
import 'package:tv_app/data/models/movie.dart';
import 'package:tv_app/data/models/series.dart';
import 'package:tv_app/data/repository/actors_repository.dart';
import 'package:tv_app/data/repository/movies_repository.dart';
import 'package:tv_app/data/repository/series_repository.dart';
import 'package:tv_app/data/web_services/actors_web_services.dart';
import 'package:tv_app/data/web_services/movies_web_services.dart';
import 'package:tv_app/data/web_services/series_web_services.dart';
import 'package:tv_app/presentation/screens/actors/actor_details_screen.dart';
import 'package:tv_app/presentation/screens/actors/popular_actors_screen.dart';
import 'package:tv_app/presentation/screens/home_screen.dart';
import 'package:tv_app/presentation/screens/movies/movie_details_screen.dart';
import 'package:tv_app/presentation/screens/movies/popular_movies_screen.dart';
import 'package:tv_app/presentation/screens/series/popular_series_screen.dart';
import 'package:tv_app/presentation/screens/series/series_details_screen.dart';

class AppRouter {

  late MoviesRepository moviesRepository;
  late MoviesCubit moviesCubit;

  late SeriesRepository seriesRepository;
  late SeriesCubit seriesCubit;

  late ActorsRepository actorsRepository;
  late ActorsCubit actorsCubit;

  AppRouter(){
    moviesRepository = MoviesRepository(MoviesWebServices());
    moviesCubit = MoviesCubit(moviesRepository);
    seriesRepository = SeriesRepository(SeriesWebServices());
    seriesCubit = SeriesCubit(seriesRepository);
    actorsRepository = ActorsRepository(ActorsWebServices());
    actorsCubit = ActorsCubit(actorsRepository);
  }

  Route? generateRoute(RouteSettings settings){
    switch(settings.name) {
      case homeScreenRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case popularMoviesRoute:
        // Make BlocProvider above the screen to create bloc
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => moviesCubit,
            child: PopularMoviesScreen(),
          ),);

        case moviesDetailsRoute:
          // send data to the details screen
          final movie = settings.arguments as Movie;
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (BuildContext context) => MoviesCubit(moviesRepository),
              child: MovieDetailsScreen(movie: movie,),
          ),);

        case popularSeriesRoute:
          return MaterialPageRoute(builder: (_) => BlocProvider(
            create: (BuildContext context) => SeriesCubit(seriesRepository),
            child: PopularSeriesScreen(),
          ));

        case seriesDetailsRoute:
          final series = settings.arguments as Series;
          return MaterialPageRoute(builder: (_) => BlocProvider(
              create: (BuildContext context) => SeriesCubit(seriesRepository),
              child: SeriesDetailsScreen(series: series,),
          ),);

        case popularActorsRoute:
          return MaterialPageRoute(builder: (_) => BlocProvider(
              create: (BuildContext context) => ActorsCubit(actorsRepository),
              child: PopularActorsScreen(),
          ),);

      case actorDetailsRoute:
        final actor = settings.arguments as Actor;
        return MaterialPageRoute(builder: (_) => BlocProvider(
          create: (BuildContext context) => ActorsCubit(actorsRepository),
          child: ActorDetailsScreen(actor: actor,),
        ),);
    }
    return null;
  }
}