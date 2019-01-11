import 'package:flutter/material.dart';
class CharacterList extends StatelessWidget {
  CharacterList({this.characters});
  final List<dynamic> characters;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView.builder(
          itemBuilder: (context, i) {
            return Text('${i+1}');
          },
          itemCount: 20,
        )
    );
  }
}