import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';
import 'CharacterList.dart';
import 'globalConstants.dart';
import 'utilities.dart';

class CharacterQuery extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  CharacterQuery({this.analytics, this.observer});
  @override
  _CharacterQueryState createState() => _CharacterQueryState();
}

class _CharacterQueryState extends State<CharacterQuery> {
  BehaviorSubject _searchOnChange; // Allows debounce on the textInput
  List<dynamic> characters = List();
  var _characterNameController = new TextEditingController();
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  _CharacterQueryState({this.analytics, this.observer}) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marvel Comics lookup'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Enter a character name:',
                      style: TextStyle(fontSize: 25),
                    ),
                    TextField(
                      controller: _characterNameController,
                      onChanged: triggerSearch,
                    ),
                  ]),
            ),
          ),
          Expanded(child: CharacterList(characters: this.characters))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => fetchCharacterInfo(_characterNameController.text),
        tooltip: 'Get a hero',
        child: Icon(Icons.chevron_right),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _searchOnChange = new BehaviorSubject<String>(onCancel: _cancelCallback);
    _searchOnChange
        .debounce(Duration(milliseconds: 1500))
        .listen((searchString) {
      fetchCharacterInfo(searchString);
    });
  }

  _cancelCallback() {
    print("Cancelling the callback");
  }

  void triggerSearch(String characterName) {
    _searchOnChange.add(characterName);
  }

  //TODO: Cancel the prior requests if we start a new one
  void fetchCharacterInfo(characterName) async {
    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    String hash = generateMd5('$timeStamp$privateKey$publicKey');
    String url =
        'https://gateway.marvel.com/v1/public/characters?nameStartsWith=$characterName&limit=10&apikey=$publicKey&hash=$hash&ts=$timeStamp';

    dynamic response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    Map<String, dynamic> responseMap = json.decode(response.body);
    Map<String, dynamic> data = responseMap["data"];
    List<dynamic> characters = data["results"];

    this.setState(() {
      this.characters = characters;
    });
  }
}
