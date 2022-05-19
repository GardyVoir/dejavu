class Movie {
  final int id;
  final String posterMini;
  final String poster;
  final String title;
  final int note;
  final int date;
  final String summary;

  const Movie({
    required this.id,
    required this.posterMini,
    required this.poster,
    required this.title,
    required this.note,
    required this.date,
    required this.summary,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      posterMini: "https://image.tmdb.org/t/p/w94_and_h141_bestv2" +
          json['poster_path'],
      poster: "https://image.tmdb.org/t/p/w300_and_h450_bestv2" +
          json['poster_path'],
      title: json['title'],
      note: json['vote_average'],
      date: json['release_date'],
      summary: json['overview'],
    );
  }
}
