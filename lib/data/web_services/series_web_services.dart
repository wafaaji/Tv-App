import 'package:dio/dio.dart';
import 'package:tv_app/constants/strings.dart';
import 'package:tv_app/data/models/popular_series.dart';
import 'package:tv_app/data/models/series_details.dart';

class SeriesWebServices{
  late Dio dio;

  SeriesWebServices(){
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
    );
    dio = Dio(options);
  }

  Future<PopularSeries> getPopularSeries(int page) async{
    try{
      Response response = await dio.get("/tv/popular?api_key=$apiKey&page=$page");
      print(response.data.toString());
      return PopularSeries.fromJson(response.data);
    }catch(e){
      print(e.toString());
      throw Exception('Failed to load popular series');
    }
  }

  Future<SeriesDetails> getSeriesDetails(int id) async{
    try{
      Response response = await dio.get('/tv/$id?api_key=$apiKey');
      print(response.data.toString());
      return SeriesDetails.fromJson(response.data);
    }catch(e){
      print(e.toString());
      throw Exception('Failed to load series details');
    }
  }
}