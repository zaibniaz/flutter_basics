import 'package:flutter/material.dart';
import 'package:mvvm_flutter_provider/models/movie_response.dart';
import 'package:mvvm_flutter_provider/utils/utils_methods.dart';

class MovieDetail extends StatelessWidget with UtilsMethods {
  final Movie movie;
  MovieDetail({@required this.movie});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(movie.title), automaticallyImplyLeading: true),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                height: 150,
                width: 150,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w185${movie.posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                movie?.title ?? '',
                style: TextStyle(
                    fontFamily: 'shui_text',
                    fontWeight: FontWeight.w700,
                    fontSize: 25.0),
              ),
              SizedBox(height: 10),
              Text(
                movie.overview,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'shui_text',
                    fontWeight: FontWeight.w300,
                    fontSize: 20.0),
              ),
              Divider(
                height: _height / 30,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(movie.popularity.toInt().toString()),
                      SizedBox(
                        height: 5,
                      ),
                      getBoldText('Popularity')
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(movie.voteAverage.toString()),
                      SizedBox(
                        height: 5,
                      ),
                      getBoldText('Average Votes')
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(movie.releaseDate),
                      SizedBox(
                        height: 5,
                      ),
                      getBoldText('Release Date')
                    ],
                  )
                ],
              ),
              Divider(
                height: _height / 30,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
