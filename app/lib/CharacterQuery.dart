import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';
import 'CharacterList.dart';
import 'LoadingDialog.dart';
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
  // So we can grab a reference to the scaffold for the snackbar
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  BehaviorSubject _searchOnChange; // Allows debounce on the textInput
  List<dynamic> characters = List();
  var _characterNameController = new TextEditingController();
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  _CharacterQueryState({this.analytics, this.observer});

  @override
  Widget build(BuildContext context) {
    // The rxDart listener for debouncing the user input. Put here because we needed access to 'context'
    _searchOnChange = new BehaviorSubject<String>(onCancel: _cancelCallback);
    _searchOnChange
        .debounce(Duration(milliseconds: 1500))
        .listen((searchString) {
      fetchCharacterInfo(characterName: searchString, context: context);
    });
    return Scaffold(
      key: _scaffoldKey,
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
    );
  }

  @override
  void initState() {
    super.initState();
  }

  _cancelCallback() {
    print("Cancelling the callback");
  }

  void triggerSearch(String characterName) {
    _searchOnChange.add(characterName);
  }

  void fetchCharacterInfo({@required characterName, @required context}) async {
    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    String hash = generateMd5('$timeStamp$privateKey$publicKey');
    String url =
        'https://gateway.marvel.com/v1/public/characters?nameStartsWith=$characterName&limit=10&apikey=$publicKey&hash=$hash&ts=$timeStamp';
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => LoadingDialog(),
      );
      dynamic response = await http
          .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
      Map<String, dynamic> responseMap = json.decode(response.body);
      Map<String, dynamic> data = responseMap["data"];
      if (data == null) {
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text("No characters by that name. Try again.")));
        return;
      }
      List<dynamic> characters = data["results"];

      this.setState(() {
        this.characters = characters;
      });
    } catch (e) {
      print("Error: " + e.toString());
      SnackBar snackBar = new SnackBar(content: Text("Error: " + e.toString()));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    } finally {
      Navigator.of(context).pop();
    }
  }
}
