import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globalConstants.dart';
import 'utilities.dart';

class ComicsList extends StatefulWidget {
  final Map<String, dynamic> comicsResponse;
  final String reasonForList;

  ComicsList({this.comicsResponse, this.reasonForList});
  @override
  _ComicsListState createState() {
    return new _ComicsListState(
        comicsResponse: this.comicsResponse,
        reasonForList: this
            .reasonForList); //Rap, I think this is where we'll take constructor parms and put them in state.
  }
}

class _ComicsListState extends State<ComicsList> {
  // A comicsResponse looks like this:
  // available: Total number of comics
  // collectionURI: url to get to all of them???
  // items: The comics returned in this batch
  // returned: The number of comics returned in this batch
  String _collectionURI;
  int _numberOfComicsAvailable;
  int _numberOfComicsInThisBatch;
  List<dynamic> _comicsList = new List<dynamic>();
  String _title;

  _ComicsListState({comicsResponse, reasonForList}) {
    _collectionURI = comicsResponse["collectionURI"];
    _numberOfComicsAvailable = comicsResponse["available"];
    _numberOfComicsInThisBatch = comicsResponse[
        "returned"]; // Should be redundant. Should be _comicsList.length.
    //_comicsList = comicsResponse["items"];
    _title =
        reasonForList?.isEmpty ?? true ? "Comics" : "Comics for $reasonForList";
    // Above bool expression means if "reasonForList is null or empty"
  }

  @override
  void initState() {
    super.initState();

    //RAP: Refactor this: should be an async pure function
    fetchComicsList();
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: Column(children: <Widget>[
          Text(
              "I'm the stateful comics list. Here we'll pass in a comicsResponse (?) and when this is loaded, we'll fetch the comics?"),
          Column(
            children: _comicsList
                .map<Widget>((comic) => new Text(comic["title"]))
                .toList(),
          ),
          Text(
              "${_numberOfComicsAvailable - _numberOfComicsInThisBatch} more ...")
        ]));
  }

  void fetchComicsList() async {
    String timeStamp = "1";
    String hash = generateMd5('$timeStamp$privateKey$publicKey');

    String url = '$_collectionURI?apikey=$publicKey&hash=$hash&ts=$timeStamp';
    try {
      final response = await http.get(
        Uri.encodeFull(url),
        headers: {"Accept": "application/json"},
      );

      print(response);
      final responseMap = json.decode(response.body);
      List<dynamic> comicsList = responseMap["data"]["results"];
      if (mounted) {
        //TODO: RAP -  Need to pull out the proper parts and display them here
        setState(() => _comicsList = comicsList);
      }
    } catch (e) {
      print("$e");
    }
  }

  fetchComic() {}
}
