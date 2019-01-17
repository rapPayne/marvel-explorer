import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'CharacterList.dart';
import 'globalConstants.dart';
import 'utilities.dart';

class CharacterQuery extends StatefulWidget {
  @override
  _CharacterQueryState createState() => _CharacterQueryState();
}

class _CharacterQueryState extends State<CharacterQuery> {
  List<dynamic> characters = List();
  final characterNameController = new TextEditingController();

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
                      controller: characterNameController,
                      onEditingComplete: () {
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
        child: Icon(Icons.chevron_right),
      ),
    );
  }

  void fetchCharacterInfo(characterName) {
    int timeStamp = DateTime.now().millisecondsSinceEpoch;
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
