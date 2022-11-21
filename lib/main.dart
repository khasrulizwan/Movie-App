import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
            title: const Text('Movie App'),
            backgroundColor: const Color.fromARGB(255, 132, 25, 17)),
        body: const HomePage(
          title: '',
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var desc = "";
  String movie = "";
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: textEditingController,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pink),
              ),
              hintText: "Search movie here",
              enabled: true,
            ),
            onChanged: (text) {
              setState(() {
                movie = text;
              });
            },
          ),
          ElevatedButton(onPressed: _pressMe, child: const Text("Search")),
          Text(desc,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Future<void> _pressMe() async {
    var apiid = "fcbadf6b";
    var url = Uri.parse('https://www.omdbapi.com/?t=$movie&apikey=$apiid');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        var title = parsedJson["Title"];
        var year = parsedJson["Year"];
        var genre = parsedJson["Genre"];
        var image = parsedJson["Poster"];
        desc =
            "Search result for $movie is $title \n\nThis movie genre is $genre and released in $year.\n\n$image";
      });
    } else {
      setState(() {
        desc = "No Record";
      });
    }
  }
}


