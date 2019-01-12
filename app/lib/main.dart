import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'CharacterList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Marvel Comics Lookup'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String characterName = "Hulk";
  List<String> characterNames = List();

  final characterNameController = new TextEditingController();
  var characterList = CharacterList();

  _MyHomePageState() {}
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Enter a character name:',
                      style: TextStyle(fontSize: 25),
                    ),
                    TextField(
                      controller: characterNameController,
                      onEditingComplete: () {
                        this.fetchCharacterInfo(this.characterNameController.text);
                        print(this.characterNameController.text);
                      },
                    ),
                  ]),
            ),
          ),

          Expanded(child: CharacterList(characters: characterNames))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Get a hero',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void fetchCharacterInfo(characterName) {
    String timeStamp = "1";
    String publicKey = "544c4bd372b1cfe780b82adb9240affe";
    String privateKey = "0b775e66cd31a25f1d0a1953cb992e9f9f219380";
    String hash = generateMd5('$timeStamp$privateKey$publicKey');
    print(hash);
    String url =
        'https://gateway.marvel.com/v1/public/characters?name=${characterName}&apikey=${publicKey}&hash=${hash}&ts=${timeStamp}';
    print(url);
    http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"}).then(
        (response) {

          this.setState(() {

          print("Response body: ${response.body}");
          Map<String, dynamic> responseMap = json.decode(response.body);
          Map<String, dynamic> data = responseMap["data"];
          List<dynamic> characters = data["results"];
          print(characters);

          // clear previous results
          this.characterNames.clear();

          for (Map<String, dynamic> character in characters) {
          this.characterNames.add(character["name"]);
          }
          print(responseMap);
          print(characterNames);
          });
    });
  }

  ///Generate MD5 hash
  generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}
