import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'globalConstants.dart';
import 'utilities.dart';
import 'Characters.dart';

class ComicDetail extends StatelessWidget {
  final comic;
  ComicDetail({@required this.comic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(comic['title']),
      ),
      body: Stack(children: <Widget>[
        Image.network(
          "${comic['thumbnail']['path']}/portrait_fantastic.${comic['thumbnail']['extension']}",
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Column(
          children: <Widget>[
            Text(comic['title'],
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
                Text(comic['description'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                ButtonTheme.bar(
                  child: ButtonBar(
                      alignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        FlatButton(
                          child: Text('CHARACTERS'),
                          onPressed: comic["characters"] == 0
                              ? null
                              : () => goToCharacterList(
                                  comic["characters"], comic['title'], context),
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
                      ]),
                ),
              ]),
            ),
          ],
        ),
      ]),
    );
  }

  void goToCharacterList(
      characterList, String comicTitle, BuildContext context) async {
    if (characterList["available"] == 0) return;
    List<dynamic> characters;

    // Fetch the characters because you have just a *subset* of that data.
    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    String hash = generateMd5('$timeStamp$privateKey$publicKey');
    try {
      String url =
          '${characterList["collectionURI"]}?apikey=$publicKey&hash=$hash&ts=$timeStamp';

      var response = await http
          .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

      Map<String, dynamic> responseMap = json.decode(response.body);
      Map<String, dynamic> data = responseMap["data"];
      characters = data["results"];
    } catch (e) {
      // Put up a snackbar with a message to try again
      print(e);
    }

    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => Characters(
                characters: characters, reason: comicTitle)));
  }
}
