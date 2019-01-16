import 'package:flutter/material.dart';
import 'CharacterQuery.dart';

// TODO: Got a little overzealous in refactoring. We may be able to skip this layer of abstraction and go right to CharacterQuery()
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   CharacterQuery();
  }
}