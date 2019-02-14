import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globalConstants.dart';
import 'utilities.dart';
import 'Characters.dart';
import 'CharacterDetail.dart';
import 'WebView.dart';

class ComicDetail extends StatelessWidget {
  final comic;
  ComicDetail({@required this.comic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(comic['title']),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            getSeriesAndNumber(comic),
            getDate(comic['dates']),
            getImages(comic, context),
            Text(emptyIfNull(comic['description'])),
            getCharacters(comic["characters"], context),
            Text("Format: " + comic['format']),
            Text("Pages: " + comic['pageCount'].toString()),
            getUrls(comic["urls"], context),
            getCreators(comic["creators"],context),
            // Stack(children: <Widget>[

            //   Column(
            //     children: <Widget>[
            //       Text(comic['title'],
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 40,
            //               fontWeight: FontWeight.bold)),
            //       Expanded(child: Container()),
            //       Container(
            //         padding: EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //           gradient: LinearGradient(
            //             begin: Alignment(0.0, -2.0),
            //             end: Alignment(0.0, 1.0),
            //             colors: <Color>[
            //               Color.fromARGB(50, 0, 0, 0),
            //               Color.fromARGB(200, 0, 0, 0)
            //             ],
            //           ),
            //         ),
            //         child: Column(children: <Widget>[
            //           Text(comic['description'],
            //               style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 15,
            //                   fontWeight: FontWeight.bold)),
            //           ButtonTheme.bar(
            //             child: ButtonBar(
            //                 alignment: MainAxisAlignment.spaceAround,
            //                 children: <Widget>[
            //                   FlatButton(
            //                     child: Text('CHARACTERS'),
            //                     onPressed: comic["characters"] == 0
            //                         ? null
            //                         : () => goToCharacterList(
            //                             comic["characters"], comic['title'], context),
            //                   ),
            //                   FlatButton(
            //                     child: Text('SERIES'),
            //                     onPressed: () => print('foo'),
            //                   ),
            //                   FlatButton(
            //                     child: Text('STORIES'),
            //                     onPressed: () => print('foo'),
            //                   ),
            //                   FlatButton(
            //                     child: Text('EVENTS'),
            //                     onPressed: () => print('foo'),
            //                   ),
            //                 ]),
            //           ),
            //         ]),
            //       ),
            //     ],
            //   ),
            // ]),
          ],
        ),
      ),
    );
  }

  // Card with list of characters
  Widget getCharacters(Map characters, BuildContext context) {
    if (characters == null) return Container();
    if (characters["available"] == 0) return Container();

    List<Widget> buttons = characters["items"]
        .map<Widget>(
          (character) => FlatButton(
              child: Text(emptyIfNull(character["name"]).toUpperCase()),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            CharacterDetail(character: character)));
              }),
        )
        .toList();
    return Card(
      elevation: 8,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("Characters appearing", style: Theme.of(context).textTheme.title),
          ),
          ButtonTheme.bar(
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: buttons,
            ),
          )
        ],
      ),
    );
  }

  // Card with the creators and roles
  Widget getCreators(Map creators, BuildContext context) {
    List<Widget> texts = new List<Widget>();
    
    creators["items"].forEach((creator) {
      String role = capitalize(creator["role"].toString());
      String creatorText = "$role: ${creator['name']}";
      Widget text = Text(creatorText);
      texts.add(text);
    });
    texts.insert(0, Text("Creators", style: Theme.of(context).textTheme.title,));
    return Card(
      child: Column(
        children: texts,
      ),
    );
  }

  // The series and number
  Widget getSeriesAndNumber(Map comic) {
    return comic["series"] == null
        ? Text(comic['title'])
        : (Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(comic['series']['name'].toString()),
              Text(comic['issueNumber'].toString()),
            ],
          ));
  }

  // Returns just the saledate of the printed comic
  Widget getDate(List dates) {
    Widget widget = Container();
    if (dates == null) return widget;
    dates.forEach((d) {
      if (d["type"] == "onsaleDate") widget = Text(d["date"]);
    });
    return widget;
  }

  // Returns a scrollable widget with images of the comic beginning with
  // a cover shot and then others (if they exist)
  Widget getImages(comic, context) {
    List<Widget> allImages = new List<Widget>();

    Widget coverShot = Image.network(
      "${comic['thumbnail']['path']}/portrait_fantastic.${comic['thumbnail']['extension']}",
      width: MediaQuery.of(context).size.width * 0.75,
      fit: BoxFit.cover,
    );

    //allImages.add(coverShot);

    //List<Widget> otherImages = new List<Widget>();
    comic["images"].forEach((image) {
      allImages.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Image.network(
          "${image['path']}/portrait_fantastic.${image['extension']}",
          width: MediaQuery.of(context).size.width * 0.75,
          fit: BoxFit.cover,
        ),
      ));
    });

    //allImages.addAll(otherImages);

    Widget images = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: allImages,
      ),
    );
    return images;
  }

  Widget getUrls(List urls, context) {
    List<Widget> widgets = new List<Widget>();
    urls.forEach((url) {
      switch (url["type"]) {
        case "detail":
          //print("Skipping detail " + url["url"]);
          break;
        case "reader":
          widgets.add(FlatButton(
            child: Text("Read now"),
            onPressed: () {
              //print("pressed " + url["url"]);
              Navigator.of(context).push(WebView(url: url["url"]));
            },
          ));
          break;
        case "purchase":
          widgets.add(FlatButton(
            child: Text("Buy from Marvel"),
            onPressed: () {
              Navigator.of(context).push(WebView(url: url["url"]));
            },
          ));
          break;
        default:
          print("Other");
          print(url);
      }
      //print(url);
    });
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widgets,
      ),
    );
  }

  void goToCharacterList(
      characterList, String comicTitle, BuildContext context) async {
    if (characterList["available"] == 0) return;
    List<dynamic> characters;

    // Fetch the characters because you have just a *subset* of that data.
    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    String hash = generateMd5('$timeStamp$privateKey$publicKey');
    try {
      String url =
          '${characterList["collectionURI"]}?apikey=$publicKey&hash=$hash&ts=$timeStamp';

      var response = await http
          .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

      Map<String, dynamic> responseMap = json.decode(response.body);
      Map<String, dynamic> data = responseMap["data"];
      characters = data["results"];
    } catch (e) {
      // Put up a snackbar with a message to try again
      print(e);
    }

    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                Characters(characters: characters, reason: comicTitle)));
  }
}
