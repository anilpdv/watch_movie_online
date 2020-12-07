import 'package:flutter/material.dart';
import 'package:movie_project/models/movie_model.dart';
import 'package:movie_project/services/movie_service.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieData extends ChangeNotifier {
  MovieObject movieObj;
  String url;
  bool loading = false;
  bool openUrl = false;

  getMoviesBySearch(String q, {int page = 1}) async {
    MovieService movieService = MovieService();
    loading = true;
    openUrl = false;
    notifyListeners();
    movieObj = await movieService.getMoviesBySearch(q, page);
    loading = false;
    notifyListeners();
  }

  getMovieUrl(String id) async {
    MovieService movieService = MovieService();
    loading = true;
    openUrl = false;
    notifyListeners();
    var response = await movieService.getMovieUrl(id);
    loading = false;

    url = response["url"];
    notifyListeners();
    try {
      _launchURL(url);
    } catch (err) {
      print(err);
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
