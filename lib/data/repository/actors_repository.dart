import 'package:tv_app/data/models/actor_details.dart';
import 'package:tv_app/data/web_services/actors_web_services.dart';
import 'package:tv_app/data/models/popular_actors.dart';

class ActorsRepository {
  final ActorsWebServices actorsWebServices;

  ActorsRepository(this.actorsWebServices);

  Future<PopularActors> getActors(int page) async{
    final popularActors = await actorsWebServices.getActor(page);
    return popularActors;
  }

  Future<ActorDetails> getActorDetails(int id) async{
    final actorDetails = await actorsWebServices.getActorDetails(id);
    return actorDetails;
  }
}