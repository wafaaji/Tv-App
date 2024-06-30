part of 'series_cubit.dart';

abstract class SeriesState {}

class SeriesInitial extends SeriesState{}

class PopularSeriesLoaded extends SeriesState{
  final List<Series> series;
  PopularSeriesLoaded(this.series);
}

class SeriesDetailsLoaded extends SeriesState{
  final SeriesDetails seriesDetails;
  SeriesDetailsLoaded(this.seriesDetails);
}