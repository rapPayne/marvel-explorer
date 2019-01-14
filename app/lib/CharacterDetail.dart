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
        body: Column(children: <Widget>[
          Container(
            height: 400,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: NetworkImage(
                    "${character['thumbnail']['path']}/portrait_fantastic.${character['thumbnail']['extension']}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(children: <Widget>[
              Text(character['name'],
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 40,
                      fontWeight: FontWeight.bold)),
            ]),
          ),
          Text(character['description']),
          Text(character['modified']),
          Text(character['resourceURI']),
          //Text(character['comics']),
          //Text(character['series']),
          //Text(character['stories']),
          //Text(character['events']),
          //Text(character['urls']),
          MaterialButton(
            onPressed: character["comics"] == 0
                ? null
                : () => goToComics(character["comics"], context),
            child: Text('comics'),
            disabledColor: Color(123),
          ),
          Text('series'),
          Text('stories'),
          Text('events'),
          Text('urls'),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Back"),
          ),
        ]));
  }

  goToComics(dynamic comics, BuildContext context) {
    if (comics["available"] == 0) return;

    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => ComicsList(comicsResponse: comics)));
    //available: number
    //collectionURI: url to get to all of them???
    //items: The comics returned
    //returned: number returned
  }
}
