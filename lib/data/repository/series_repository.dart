import 'package:tv_app/data/models/popular_series.dart';
import 'package:tv_app/data/models/series_details.dart';
import 'package:tv_app/data/web_services/series_web_services.dart';

class SeriesRepository{
  final SeriesWebServices seriesWebServices;

  SeriesRepository(this.seriesWebServices);

  Future<PopularSeries> getPopularSeries(int page) async{
    final popularSeries = await seriesWebServices.getPopularSeries(page);
    return popularSeries;
  }

  Future<SeriesDetails> getSeriesDetails(int id) async{
    final seriesDetails = await seriesWebServices.getSeriesDetails(id);
    return seriesDetails;
  }
}