import 'dart:core';

import 'package:mvvm_flutter_provider/models/movie_item_model.dart';
import 'package:mvvm_flutter_provider/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<MovieItemModel>();

  Observable<MovieItemModel> get allmovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    if (_isDisposed) {
      return;
    }
    MovieItemModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  bool _isDisposed = false;
  void dispose() {
    _moviesFetcher.close();
    _isDisposed = true;
  }
}

//final bloc = MoviesBloc();
