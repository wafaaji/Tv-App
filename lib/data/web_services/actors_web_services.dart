import 'package:dio/dio.dart';
import 'package:tv_app/constants/strings.dart';
import 'package:tv_app/data/models/actor_details.dart';
import 'package:tv_app/data/models/popular_actors.dart';

class ActorsWebServices {

  late Dio dio;
  ActorsWebServices(){
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
    );
    dio = Dio(options);
  }

  Future<PopularActors> getActor(int page) async{
    try{
      Response response = await dio.get("/person/popular?api_key=$apiKey&page=$page");
      print(response.data.toString());
      return PopularActors.fromJson(response.data);
    }catch(e){
      print(e.toString());
      throw Exception("Failed to load popular actor");
    }
  }

  Future<ActorDetails> getActorDetails(int id) async{
    try{
      Response response = await dio.get('/person/$id?api_key=$apiKey');
      print(response.data.toString());
      return ActorDetails.fromJson(response.data);
    }catch(e){
      print(e.toString());
      throw Exception('Failed to load actor details');
    }
  }
}