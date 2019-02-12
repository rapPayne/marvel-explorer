// This widget is an entire scene with its own scaffold to host a
// list of Characters when they're already populated - as in a
// list has been passed to it from above.
// To have the user query for a character, user CharacterQuery.dart.

import 'package:flutter/material.dart';
import 'CharacterList.dart';

class Characters extends StatelessWidget {
  final List<dynamic> characters;
  final String reason;

  Characters({this.characters, this.reason=""});

  @override
  Widget build(BuildContext context) {
    String reasonForList = reason.isEmpty ? "" : " in $reason";
    return Scaffold(
      appBar: AppBar(
        title: Text('Characters$reasonForList'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: CharacterList(characters: this.characters),
          ),
        ],
      ),
    );
  }
}
