import 'package:flutter/material.dart';
import 'ComicsList.dart';

class CharacterDetail extends StatelessWidget {
  final dynamic character;
  CharacterDetail({this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character['name']),
      ),
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
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
              Text(character['description']),
            ],
          ),
        ]),
        // Text(character['modified']),
        // Text(character['resourceURI']),
        //Text(character['urls']),
      ),
      persistentFooterButtons: <Widget>[
              FlatButton(
                child: Text('Comics'),
                onPressed: character["comics"] == 0
                    ? null
                    : () => goToComics(character["comics"], context),
              ),
              FlatButton(
                child: Text('Series'),
                onPressed: () => print('foo'),
              ),
              FlatButton(
                child: Text('Stories'),
                onPressed: () => print('foo'),
              ),
              FlatButton(
                child: Text('Events'),
                onPressed: () => print('foo'),
              ),
      ],
    );
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
