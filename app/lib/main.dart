import 'package:flutter/material.dart';
import 'MainPage.dart';
import 'CharacterQuery.dart';
import 'CharacterList.dart';
import 'ComicsList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // TODO: RAP - These routes are not being used properly. Refactor later.
      initialRoute: "MainPage",
      routes: <String, WidgetBuilder>{
        "CharacterQuery": (BuildContext context) => CharacterQuery(),
        "CharacterList": (BuildContext context) => CharacterList(),
        "ComicsList": (BuildContext context) => ComicsList(),
        "MainPage": (BuildContext context) => MainPage(),
      },
      title: 'Marvel Comics Lookup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}