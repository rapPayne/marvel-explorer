import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globalConstants.dart';
import 'utilities.dart';
import 'CharacterList.dart';

class MainPage extends StatefulWidget {
  final String title;
  MainPage({Key key, this.title}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String characterName;
  List<dynamic> characters = List();

  final characterNameController = new TextEditingController();

  _MainPageState();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                      controller: characterNameController,
                      onEditingComplete: (){
                        FocusScope.of(context).requestFocus(new FocusNode());
                        fetchCharacterInfo(characterNameController.text);
                      },
                    ),
                  ]),
            ),
          ),
          Expanded(child: CharacterList(characters: this.characters))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => fetchCharacterInfo(this.characterNameController.text),
        tooltip: 'Get a hero',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void fetchCharacterInfo(characterName) {
    String timeStamp = "1";
    String hash = generateMd5('$timeStamp$privateKey$publicKey');
    String url =
        'https://gateway.marvel.com/v1/public/characters?nameStartsWith=$characterName&apikey=$publicKey&hash=$hash&ts=$timeStamp';

    http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"}).then(
        (response) {
      Map<String, dynamic> responseMap = json.decode(response.body);
      Map<String, dynamic> data = responseMap["data"];
      List<dynamic> characters = data["results"];

      this.setState(() {
        this.characters = characters;   
      });
    });
  }
}