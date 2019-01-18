import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globalConstants.dart';
import 'utilities.dart';
import 'ComicBrief.dart';

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
  // collectionURI: url to get to all of them
  // items: The comics returned in this batch
  // returned: The number of comics returned in this batch
  String _collectionURI;
  int _numberOfComicsAvailable;
  int _numberOfComicsDisplayed;
  List<dynamic> _comicsList = new List<dynamic>();
  String _title;

  _ComicsListState({comicsResponse, reasonForList}) {
    _collectionURI = comicsResponse["collectionURI"];
    _numberOfComicsAvailable = comicsResponse["available"];
    // _numberOfComicsDisplayed = comicsResponse[
    //     "returned"]; // Should be redundant. Should be _comicsList.length.
    //_comicsList = comicsResponse["items"];
    _title =
        reasonForList?.isEmpty ?? true ? "Comics" : "Comics for $reasonForList";
    // Above bool expression means if "reasonForList is null or empty"
  }

  @override
  void initState() {
    super.initState();
    _numberOfComicsDisplayed = 0;
    _comicsList.clear();
    fetchMoreComics(5, _numberOfComicsDisplayed)
        .then((firstComics) => addToComicsList(firstComics));
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 300.0,
        children: _comicsList
            .map<Widget>((comic) => new ComicBrief(comic: comic))
            .toList(),
      ),
      floatingActionButton: RaisedButton(
        onPressed: () => fetchMoreComics(5, _numberOfComicsDisplayed)
            .then((firstComics) => addToComicsList(firstComics)),
        child: Text(
            "${_numberOfComicsAvailable - _numberOfComicsDisplayed} more ..."),
      ),
    );
  }

  // Fetches X more comics, having skipped Y from the API.
  Future<List<dynamic>> fetchMoreComics(
      int numberToFetch, int numberToSkip) async {
    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    String hash = generateMd5('$timeStamp$privateKey$publicKey');
    List<dynamic> comicsList = new List<dynamic>();

    if (numberToFetch > _numberOfComicsAvailable - _numberOfComicsDisplayed)
      numberToFetch = _numberOfComicsAvailable - _numberOfComicsDisplayed;

    String url =
        '$_collectionURI?limit=$numberToFetch&offset=$numberToSkip&apikey=$publicKey&hash=$hash&ts=$timeStamp';
    try {
      final response = await http.get(
        Uri.encodeFull(url),
        headers: {"Accept": "application/json"},
      );

      final responseMap = json.decode(response.body);
      comicsList = (responseMap["data"]["results"] as List<dynamic>);
    } catch (e) {
      print("$e");
    }
    return comicsList;
  }

  void addToComicsList(List<dynamic> newComics) {
    if (mounted)
      setState(() {
        _numberOfComicsDisplayed += newComics.length;
        _comicsList.addAll(newComics);
      });
  }

//TODO: Rap - Write this to get each book.
  fetchComic() {}
}
