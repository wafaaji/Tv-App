import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_app/data/models/actor.dart';
import 'package:tv_app/data/models/actor_details.dart';
import 'package:tv_app/data/models/popular_actors.dart';
import 'package:tv_app/data/repository/actors_repository.dart';

part 'actors_state.dart';

class ActorsCubit extends Cubit<ActorsState>{
  final ActorsRepository actorsRepository;
  PopularActors? popularActors;
  int currentPage = 1;
  bool isLoading = false;
  List<Actor> actor = [];
  ActorDetails? actorDetails;

  ActorsCubit(this.actorsRepository): super(ActorsInitial());

  void getPopularActors() {
    if (isLoading) return;

    isLoading = true;
    actorsRepository.getActors(currentPage).then((popularActors) {
      currentPage++;
      // Take From Repository And Send To The UI
      actor.addAll(popularActors.actor);
      emit(PopularActorsLoaded(actor));
      isLoading = false;
    });
  }

  void getActorDetails(int id) {
    actorsRepository.getActorDetails(id).then((actorDetails) {
      // Take From Repository And Send To The UI
      emit(ActorDetailsLoaded(actorDetails));
    });
  }
}