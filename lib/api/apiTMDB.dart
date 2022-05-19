class apiTMDB {
  var api_key = "&api_key=151dfa1b4c6a83a02970c0c6612615b3";

    getMovieWithSearch(String query) {
        return "https://api.themoviedb.org/3/search/movie?query="+ query + api_key;
    }
}