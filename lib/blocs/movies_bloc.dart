import 'dart:core';

import 'package:mvvm_flutter_provider/general_api_response/api_response.dart';
import 'package:mvvm_flutter_provider/models/movie_response.dart';
import 'package:mvvm_flutter_provider/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<ApiResponse<List<Movie>>>();

  Observable<ApiResponse<List<Movie>>> get allmovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    if (_isDisposed) {
      return;
    }
    _moviesFetcher.sink.add(ApiResponse.loading('Fetching Popular Movies'));
    try {
      List<Movie> movies = await _repository.fetchMovieList();
      _moviesFetcher.sink.add(ApiResponse.completed(movies));
    } catch (e) {
      _moviesFetcher.sink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  bool _isDisposed = false;
  void dispose() {
    _moviesFetcher.close();
    _isDisposed = true;
  }
}

//final bloc = MoviesBloc();
