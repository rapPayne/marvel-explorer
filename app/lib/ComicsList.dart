import 'package:flutter/material.dart';

class ComicsList extends StatelessWidget {
  // A comicsResponse looks like this:
  // available: Total number of comics
  // collectionURI: url to get to all of them???
  // items: The comics returned in this batch
  // returned: The number of comics returned in this batch
  String _collectionURI;
  int _numberOfComicsAvailable;
  int _numberOfComicsInThisBatch;
  List<dynamic> _comicsList;
  String _title;
  
  final Map<String, dynamic> comicsResponse;
  final String reasonForList;
  ComicsList({this.comicsResponse, this.reasonForList}) {
    _collectionURI = comicsResponse["collectionURI"];
    _numberOfComicsAvailable = comicsResponse["available"];
    _numberOfComicsInThisBatch = comicsResponse["returned"]; // Should be redundant. Should be _comicsList.length.
    _comicsList = comicsResponse["items"];
    _title = reasonForList?.isEmpty ?? true ? "Comics" : "Comics for $reasonForList";
    // Above bool expression means if "reasonForList is null or empty"
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: Column(children: <Widget>[
          Text(
              "I'm comics list. Here we'll pass in a comicsResponse (?) and when this is loaded, we'll fetch the comics?"),
          Column(
            children: _comicsList
                .map<Widget>((comic) => new Text(comic["name"]))
                .toList(),
          ),
          Text("${_numberOfComicsAvailable - _numberOfComicsInThisBatch} more ...")
        ]));
  }
}
