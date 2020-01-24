import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:mvvm_flutter_provider/exceptions_handling/app_exception.dart';

class MovieApiProvider {
  Client client = new Client();

  final _baseUrl = 'http://api.themoviedb.org/3/movie';

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await client.get(_baseUrl + url);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
