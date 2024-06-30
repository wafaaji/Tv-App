import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_app/data/models/popular_series.dart';
import 'package:tv_app/data/models/series.dart';
import 'package:tv_app/data/models/series_details.dart';
import 'package:tv_app/data/repository/series_repository.dart';

part 'series_state.dart';

class SeriesCubit extends Cubit<SeriesState>{
  final SeriesRepository seriesRepository;
  PopularSeries? popularSeries;
  int currentPage = 1;
  bool isLoading = false;
  List<Series> series = [];
  SeriesDetails? seriesDetails;

  SeriesCubit(this.seriesRepository): super(SeriesInitial());

  void getPopularSeries() {
    if (isLoading) return;

    isLoading = true;
    seriesRepository.getPopularSeries(currentPage).then((popularSeries) {
      currentPage++;
      // Take From Repository And Send To The UI
      series.addAll(popularSeries.series);
      emit(PopularSeriesLoaded(series));
      isLoading = false;
    });
  }

  void getSeriesDetails(int id) {
    seriesRepository.getSeriesDetails(id).then((seriesDetails) {
      // Take From Repository And Send To The UI
      emit(SeriesDetailsLoaded(seriesDetails));
    });
  }

}