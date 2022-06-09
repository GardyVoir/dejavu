import 'package:http/http.dart' as http;

class apiTMDB {
  static const BASE_URL = "https://api.themoviedb.org/3/",
      IMAGE_URL = "http://image.tmdb.org/t/p/",
      API_KEY = "?api_key=147559df849452102f2d124c5bcd04d5";

  static getMovieWithSearch(String query) async {
    return await http.get(
        Uri.parse(BASE_URL + "search/movie" + API_KEY + "&query=" + query));
  }

  static getMovieDetail(int id) async {
    return await http
        .get(Uri.parse(BASE_URL + 'movie/' + id.toString() + API_KEY));
  }

  static getMovieImg(String imgPath) async {
    return await http.get(Uri.parse(IMAGE_URL + imgPath));
  }
}
