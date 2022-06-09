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
      title: 'Déjà Vu',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Avez-vous Déjà Vu ...'),
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
  List<Movie> _movieList = <Movie>[];
  @override
  void initState() {
    super.initState();
  }

  final myController = TextEditingController();

  getMoviesFromSearch(String query) async {
    final response = await apiTMDB.getMovieWithSearch(query);
    List<Movie> ListMovie = <Movie>[];
    if (response.statusCode == 200) {
      Map<String, dynamic> values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values["results"].length; i++) {
          if (values["results"][i] != null) {
            ListMovie.add(Movie.fromJson(values["results"][i]));
          }
        }
      }
    }
    setState(() {
      _movieList = ListMovie;
    });
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(hintText: 'Enter movie name'),
                onSubmitted: (value) {
                  getMoviesFromSearch(value);
                },
                controller: myController,
              ),
            ),
            Expanded(
              child: ListView(
                children:
                    _movieList.map((m) => _buildMovie(m, context)).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await getMoviesFromSearch(myController.text);
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}

Widget _buildMovie(Movie e, BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(5),
    child: Container(
      color: Colors.white10,
      child: ListTile(
        contentPadding: EdgeInsets.all(5),
        dense: true,
        onTap: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Details(id: e.id)));
        },
        leading: _poster(e.posterMini),
        title: Text(
          e.title,
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text(e.summary ?? "Pas de synopsis"),
        //trailing: Icon(Icons.movie),
      ),
    ),
  );
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
