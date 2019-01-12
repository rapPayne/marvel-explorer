import 'package:flutter/material.dart';

class CharacterDetail extends StatelessWidget {
  final dynamic character;
  CharacterDetail({this.character});

  @override
  Widget build(BuildContext context) {
    return Center(child:Text("I'm Character Detail ${character['name']}"));
  }
}