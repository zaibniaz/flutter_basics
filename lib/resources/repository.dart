
import 'package:mvvm_flutter_provider/models/movie_response.dart';
import 'package:mvvm_flutter_provider/resources/movie_api_provider.dart';

class Repository {
  final MovieApiProvider movieApiProvider = new MovieApiProvider();
  final apiKey = 'c9df6a11708c1aa0695960cd503ee23a';

  Future<List<Movie>> fetchMovieList() async {
    final response = await movieApiProvider.get("/popular?api_key=$apiKey");

    return MovieResponse.fromJson(response).results;
  }
}
