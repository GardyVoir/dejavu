class Movie {
  final int id;
  final String? posterMini;
  final String? poster;
  final String title;
  final double? note;
  final String? date;
  final String? summary;

  const Movie({
    required this.id,
    this.posterMini,
    this.poster,
    required this.title,
    this.note,
    this.date,
    this.summary,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      posterMini: json['poster_path'] != null
          ? "https://image.tmdb.org/t/p/w94_and_h141_bestv2" +
              json['poster_path']
          : null,
      poster: json['poster_path'] != null
          ? "https://image.tmdb.org/t/p/w300_and_h450_bestv2" +
              json['poster_path']
          : null,
      title: json['title'],
      note: json['vote_average'] is double
          ? json['vote_average']
          : json['vote_average'].toDouble(),
      date: json['release_date'],
      summary: json['overview'],
    );
  }
}
