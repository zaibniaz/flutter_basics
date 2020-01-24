import 'package:flutter/material.dart';
import 'package:mvvm_flutter_provider/models/movie_item_model.dart';
import '../blocs/movies_bloc.dart';

class MovieList extends StatefulWidget {
  @override
  MovieListState createState() => MovieListState();
}

class MovieListState extends State<MovieList> {
  final bloc = MoviesBloc();

  @override
  void initState() {
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: StreamBuilder(
              stream: bloc.allmovies,
              builder: (context, AsyncSnapshot<MovieItemModel> snapShot) {
                if (snapShot.hasData) {
                  return buildList(snapShot);
                } else if (snapShot.hasError) {
                  return Text(snapShot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              })),
    );
  }

  Widget buildList(AsyncSnapshot<MovieItemModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].poster_path}',
                fit: BoxFit.cover,
              ),
            ),
          );
        });
  }
}
