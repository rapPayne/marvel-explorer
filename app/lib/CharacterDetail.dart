import 'package:flutter/material.dart';

class CharacterDetail extends StatelessWidget {
  final dynamic character;
  CharacterDetail({this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character['name']),
      ),
    body: Center(
      child: Column(children: <Widget>[
        Text("I'm Character Detail ${character['name']}"),
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Back"),
          ),
        Text("I'm Character Detail ${character['name']}"),
      ]),
    )
    );
  }
}
