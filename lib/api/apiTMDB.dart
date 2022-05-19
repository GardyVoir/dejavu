class apiTMDB {
    static const BASE_URL = "https://api.themoviedb.org/3/",
    IMAGE_URL = "http://image.tmdb.org/t/p/",
    API_KEY = "?api_key=151dfa1b4c6a83a02970c0c6612615b3",
    SEARCH_QUERY = "search/movie?query=";
  
    static getMovieWithSearch(String query) {
        return BASE_URL + SEARCH_QUERY + query + API_KEY;
    }

    static getMovieDetail(String id) {
        return BASE_URL + 'movie/' + id + API_KEY;
    }

    static getMovieImg(String imgPath) {
        return IMAGE_URL + imgPath;
    }
}