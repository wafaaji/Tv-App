part of 'actors_cubit.dart';

abstract class ActorsState{}

class ActorsInitial extends ActorsState{}

class PopularActorsLoaded extends ActorsState{
  final List<Actor> actor;
  PopularActorsLoaded(this.actor);
}

class ActorDetailsLoaded extends ActorsState {
  final ActorDetails actorDetails;

  ActorDetailsLoaded(this.actorDetails);
}