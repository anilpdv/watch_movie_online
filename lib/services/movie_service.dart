import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_project/constants.dart';
import 'package:movie_project/models/movie_model.dart';
import 'package:movie_project/services/public_ip_service.dart';

class MovieService {
  Future<MovieObject> getMoviesBySearch(String q, int page) async {
    try {
      http.Response response =
          await http.get(kAPI_URL + '&s=' + q + '&p=' + page.toString());
      if (response.statusCode == 200) {
        var reqData = json.decode(response.body);
        MovieObject movieObj = MovieObject.fromJson(reqData);
        return movieObj;
      } else {
        throw Exception('Failed to load Movies, try again!');
      }
    } catch (err) {
      throw Exception('Failed to load Movies, try again!');
    }
  }

  Future<dynamic> getMovieUrl(String id) async {
    try {
      String ipRes = await getPublicIP();
      String url = '$kMovie_URL$id?ip=$ipRes';
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var reqData = json.decode(response.body);
        return reqData;
      } else {
        throw Exception("error while fetching movie url");
      }
    } catch (err) {
      throw Exception("error while fetching movie url");
    }
  }
}
