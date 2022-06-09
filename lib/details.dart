import 'dart:convert';

import 'package:dejavu/api/apiTMDB.dart';
import 'package:dejavu/classes/Movie.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final int id;
  Details({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DetailsState();
  }
}

class DetailsState extends State<Details> {
  Future<Movie> fetchMovie() async {
    final response = await apiTMDB.getMovieDetail(widget.id);

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
        title: const Text("Détails"),
      ),
      body: FutureBuilder(
          future: fetchMovie(),
          builder: (BuildContext context, AsyncSnapshot<Movie> movie) {
            List<Widget> children;
            if (movie.hasData) {
              children = <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: movie.data!.poster == null
                                ? Container()
                                : Container(
                                    width: 300,
                                    height: 450,
                                    child: _poster(movie.data!.poster),
                                  ),
                          ),
                          Center(
                              child: Text(movie.data!.title,
                                  style:
                                      Theme.of(context).textTheme.headline4)),
                          movie.data!.date == null
                              ? Container()
                              : movie.data!.date!.isEmpty
                                  ? Container()
                                  : Text(
                                      "(${movie.data!.date!.substring(0, 4)})"),
                          //Text(movie.data!.note.toString()),
                          Text(movie.data!.summary ?? "Pas de synopsis")
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            } else if (movie.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${movie.error}'),
                )
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Chargement...'),
                )
              ];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            );
          }),
    );
  }
}

Widget _poster(String? url) {
  if (url == null || url.isEmpty) {
    return Container(
      height: 0,
      width: 0,
    );
  }
  return Image.network(url);
}
