import 'package:flutter/material.dart';
import 'package:mvvm_flutter_provider/common_components/error_connection_widget.dart';
import 'package:mvvm_flutter_provider/common_components/loading_view_widget.dart';
import 'package:mvvm_flutter_provider/general_api_response/api_response.dart';
import 'package:mvvm_flutter_provider/models/movie_response.dart';
import 'package:mvvm_flutter_provider/views/movie_detail.dart';
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
        child: StreamBuilder<ApiResponse<List<Movie>>>(
          stream: bloc.allmovies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("Loading$snapshot.data.status");
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return LoadingViewWidget(
                      loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return buildList(snapshot.data.data);
                  break;
                case Status.ERROR:
                  return ErrorConnectionWidget(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => bloc.allmovies,
                  );
                  break;
              }
            }
            return LoadingViewWidget(loadingMessage: 'Fetching Movies');
          },
        ),
      ),
    );
  }

  Widget buildList(List<Movie> snapshot) {
    return GridView.builder(
        itemCount: snapshot.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot[index].posterPath}',
                fit: BoxFit.cover,
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) =>
                          MovieDetail(movie: snapshot[index]))),
            ),
          );
        });
  }
}
