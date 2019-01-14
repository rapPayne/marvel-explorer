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
        children: getComicsBriefWidgets(comicsResponse["items"])
      )
    ])
    );
  }

  List<Widget> getComicsBriefWidgets(dynamic comicsList) {
    List<Widget> comicsBriefs = new List<Widget>();
    for (int i=0; i<comicsList.length; i++) {
      dynamic comic = comicsList[i];
      comicsBriefs.add(Text(comic["name"]));
    }
    return comicsBriefs;
  }
}
