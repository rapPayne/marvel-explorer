import 'package:flutter/material.dart';
import 'CharacterBrief.dart';

class CharacterList extends StatelessWidget {
  CharacterList({this.characters});
  final List<dynamic> characters;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView.builder(
          itemBuilder: (context, i) {
            print("Character is ${characters[i]}");
            return CharacterBrief(character: characters[i]);
          },
          itemCount: characters.length,
        )
    );
  }
}