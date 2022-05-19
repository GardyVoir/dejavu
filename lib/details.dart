import 'dart:convert';

import 'package:dejavu/api/apiTMDB.dart';
import 'package:dejavu/classes/Movie.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final int id;
  const Details({Key? key, required this.id}) : super(key: key);
  late Future<Movie> futureMovie;

  @override
  void initState() {
    super.initState();
    futureMovie = fetchMovie();
  }

  Future<Movie> fetchMovie() async {
    final response = await apiTMDB.getMovieDetail(id);

    if (response.statusCode == 200) {
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load movie');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Route"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

//   Navigator.push(context, MaterialPageRoute(builder: (context) => Details(id: XXXX)));