import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/src/models/actors_model.dart';

import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {
  String _apiKey = '';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularsPage = 0;
  bool _loading = false;

  List<Movie> _populars = new List();

  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams() {
    _popularsStreamController?.close();
  }

  Future<List<Movie>> getOnCinema() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});
    return await _processResponse(url);
  }

  Future<List<Movie>> getPopulars() async {
    if (_loading) return [];
    _loading = true;

    _popularsPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularsPage.toString()
    });

    final response = await _processResponse(url);
    _populars.addAll(response);
    popularsSink(_populars);

    _loading = false;
    return response;
  }

  Future<List<Movie>> _processResponse(Uri url) async {
    final response = await http.get(url);
    final decodeData = json.decode(response.body);
    final movies = new Movies.fromJsonList(decodeData['results']);

    return movies.items;
  }

  Future<List<Actor>> getCast(String movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits',
        {'api_key': _apiKey, 'language': _language});
    final response = await http.get(url);
    final decodeData = jsonDecode(response.body);
    final cast = new Cast.fromJsonList(decodeData['cast']);
    return cast.actors;
  }
}
