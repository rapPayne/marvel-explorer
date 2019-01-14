import 'package:flutter/material.dart';

class ComicsList extends StatelessWidget {
  final Map<String, dynamic> comicsResponse;
  ComicsList({this.comicsResponse});

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('comics'),
        ),
        body: Column(children: <Widget>[
      Text(
        "I'm comics list. Here we'll pass in a comicsResponse (?) and when this is loaded, we'll fetch the comics?"),
      Column(
        children: comicsResponse["items"].map<Widget>((comic) => new Text(comic["name"])).toList(),
      )
    ])
    );
  }

}
