import 'package:flutter/material.dart';
import "CharacterDetail.dart";

class CharacterBrief extends StatelessWidget {
  final dynamic character;
  CharacterBrief({this.character});

  @override
  Widget build(BuildContext context) {
    //print("The char:" + this.character.toString());
    String imageUrl = "";
    if (character["thumbnail"] != null) {
      imageUrl =
          '${character["thumbnail"]["path"]}/portrait_small.${character["thumbnail"]["extension"]}';
    }

    return GestureDetector( // When user taps this, bring up the character details.
        onTap: () {
          Navigator.push(context, 
            new MaterialPageRoute(
              builder: (context) => CharacterDetail(character:this.character))
          );
        },
        child: Card(
          margin: EdgeInsets.all(5),
          child: Row(
            children: <Widget>[
              Image.network(imageUrl),
              Text(character["name"]),
            ],
          ),
        ));
  }
}
