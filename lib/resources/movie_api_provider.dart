import 'dart:convert';

import 'package:http/http.dart';
import 'package:mvvm_flutter_provider/models/movie_item_model.dart';

class MovieApiProvider {
  Client client = new Client();
  final api_key = 'f944bd4c';
  final _baseUrl =
      'http://api.themoviedb.org/3/movie';


    Future<MovieItemModel> fetchLovieList() async
    {
      Response response;
      if(api_key!='api_key')
      {
        response= await client.get('$_baseUrl/popular?api_key=$api_key');
      }
      else
      {
        throw Exception('Add an API key');
      }

      if(response.statusCode==200)
      {
        return MovieItemModel.fromJson(json.decode(response.body));
      }
      
      else{
        throw Exception('Failed to Load post');
      }

    }
}
