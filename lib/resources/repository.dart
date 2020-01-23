import 'package:mvvm_flutter_provider/models/movie_item_model.dart';
import 'package:mvvm_flutter_provider/resources/movie_api_provider.dart';

class Repository
{
 final MovieApiProvider movieApiProvider=new MovieApiProvider();

  Future<MovieItemModel>  fetchAllMovies()  => movieApiProvider.fetchLovieList();
}