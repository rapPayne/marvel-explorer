import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ComicsList.dart';
import 'sensitiveConstants.dart';
import 'utilities.dart';

class CharacterDetail extends StatefulWidget {
  final dynamic character;
  CharacterDetail({this.character});

  @override
  _CharacterDetailState createState() {
    return _CharacterDetailState(character: character);
  }
}

class _CharacterDetailState extends State<CharacterDetail> {
  final dynamic character;
  _CharacterDetailState({this.character}) {
    _fetchCharacterByURI(this.character["resourceURI"]);
  }

  void _fetchCharacterByURI(String uri) async {
    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    String hash = generateMd5('$timeStamp$privateKey$publicKey');
    String url = '$uri?apikey=$publicKey&hash=$hash&ts=$timeStamp';

    //TODO: Put errors in a snackbar
    try {
      dynamic response = await http
          .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
      Map<String, dynamic> responseMap = json.decode(response.body);
      Map<String, dynamic> data = responseMap["data"];
      List<dynamic> character = data["results"];

      this.setState(() {
        character = character;
      });
    } catch (e) {
      print("Marvel's server appears to be down. Try again later.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character['name']),
      ),
      body: Stack(children: <Widget>[
        Image.network(
          "${character['thumbnail']['path']}/portrait_fantastic.${character['thumbnail']['extension']}",
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Column(
          children: <Widget>[
            Text(character['name'],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
            Expanded(child: Container()),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.0, -2.0),
                  end: Alignment(0.0, 1.0),
                  colors: <Color>[
                    Color.fromARGB(50, 0, 0, 0),
                    Color.fromARGB(200, 0, 0, 0)
                  ],
                ),
              ),
              child: Column(children: <Widget>[
                Text(character['description'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                ButtonTheme.bar(
                    child: ButtonBar(
                        alignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                      FlatButton(
                        child: Text('COMICS'),
                        onPressed: character["comics"] == 0
                            ? null
                            : () => goToComics(character["comics"], context),
                      ),
                      FlatButton(
                        child: Text('SERIES'),
                        onPressed: () => print('foo'),
                      ),
                      FlatButton(
                        child: Text('STORIES'),
                        onPressed: () => print('foo'),
                      ),
                      FlatButton(
                        child: Text('EVENTS'),
                        onPressed: () => print('foo'),
                      ),
                    ])),
              ]),
            ),
          ],
        ),
      ]),
    );
    // Text(character['modified']),
    // Text(character['resourceURI']),
    // Text(character['urls']),
    //);
  }

  goToComics(dynamic comics, BuildContext context) {
    if (comics["available"] == 0) return;

    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => ComicsList(
                comicsResponse: comics, reasonForList: character["name"])));
  }
}
