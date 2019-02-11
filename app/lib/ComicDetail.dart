import 'package:flutter/material.dart';

class ComicDetail extends StatefulWidget {
  final comic;

  ComicDetail({this.comic});

  _ComicDetailState createState() => new _ComicDetailState(comic);
}

class _ComicDetailState extends State<ComicDetail> {
  final comic;
  _ComicDetailState(this.comic) {
    print(comic);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(comic['title']),
      ),
      body: Stack(children: <Widget>[
        Image.network(
          "${comic['thumbnail']['path']}/portrait_fantastic.${comic['thumbnail']['extension']}",
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Column(
          children: <Widget>[
            Text(comic['title'],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
            Expanded(child: Container()),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.0, -2.0),
                  end: Alignment(0.0, 1.0),
                  colors: <Color>[
                    Color.fromARGB(50, 0, 0, 0),
                    Color.fromARGB(200, 0, 0, 0)
                  ],
                ),
              ),
              child: Column(children: <Widget>[
                Text(comic['description'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                ButtonTheme.bar(
                    child: ButtonBar(
                        alignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                      FlatButton(
                        child: Text('CHARACTERS'),
                        onPressed: comic["characters"] == 0
                            ? null
                            : () => goToCharacterList(comic["characters"], context),
                      ),
                      FlatButton(
                        child: Text('SERIES'),
                        onPressed: () => print('foo'),
                      ),
                      FlatButton(
                        child: Text('STORIES'),
                        onPressed: () => print('foo'),
                      ),
                      FlatButton(
                        child: Text('EVENTS'),
                        onPressed: () => print('foo'),
                      ),
                    ])),
              ]),
            ),
          ],
        ),
      ]),
    );
  }

  void goToCharacterList(characterList, BuildContext context) {
    print("Go to characterList");
  }
}
