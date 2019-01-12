import 'package:flutter/material.dart';

class CharacterBrief extends StatelessWidget {
  final dynamic character;
  CharacterBrief({this.character});

  @override
  Widget build(BuildContext context) {
    print("The char:" + this.character.toString());
    String imageUrl = "";
    if (character["thumbnail"] != null) {
      imageUrl =
          '${character["thumbnail"]["path"]}/portrait_small.${character["thumbnail"]["extension"]}';
    }

    return Card(
      child: Row(
        children: <Widget>[
          Image.network(imageUrl),
          Text(character["name"]),
        ],
      ),
    );
  }
}
