import 'dart:convert';
import 'movie.dart';
import 'package:http/http.dart' as http;


class Api{

  final nowPlayingApiUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=e3330843b55bf27874a3a58513eba7f6";
  final upComingApiUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=e3330843b55bf27874a3a58513eba7f6";
  

  Future<List<Movie>> getNowPlayingMovies() async{
    final response = await http.get(Uri.parse(nowPlayingApiUrl));

    if(response.statusCode == 200){
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    }else{
      throw Exception('Failed to load now playing movies');
    }

  }

  Future<List<Movie>> getUpcomingMovies() async{
    final response = await http.get(Uri.parse(upComingApiUrl));

    if(response.statusCode == 200){
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    }else{
      throw Exception('Failed to load upcoming movies');
    }

  }


}