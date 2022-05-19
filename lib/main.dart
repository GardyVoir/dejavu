import 'dart:convert';

import 'package:flutter/material.dart';
import 'api/apiTMDB.dart';
import 'classes/Movie.dart';
import 'details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  final myController = TextEditingController();

  Future<List<Movie>> getMoviesFromSearch(String query) async {
    List<Movie> _movieList = <Movie>[];
    final response = await apiTMDB.getMovieWithSearch(query);

    if (response.statusCode == 200) {
      Map<String, dynamic> values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values["results"].length; i++) {
          if (values["results"][i] != null) {
            _movieList.add(Movie.fromJson(values["results"][i]));
          }
        }
      }
    }
    return _movieList;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var List = await getMoviesFromSearch(myController.text);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => Details(id: 675)));
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}
