import 'package:flutter/material.dart';
import "CharacterDetail.dart";

class CharacterBrief extends StatelessWidget {
  final dynamic character;
  CharacterBrief({this.character});

  @override
  Widget build(BuildContext context) {
    String imageUrl = "";
    if (character["thumbnail"] != null) {
      imageUrl =
          '${character["thumbnail"]["path"]}/portrait_small.${character["thumbnail"]["extension"]}';
    }

    return GestureDetector(
        // When user taps this, bring up the character details.
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                      CharacterDetail(character: this.character)));
        },
        child: Card(
          margin: EdgeInsets.all(5),
          child: Row(
            children: <Widget>[
              Image.network(imageUrl),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  character["name"],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ));
  }
  // Big, pretty cards that Raffi added below. Thought we needed a list instead.
  // Widget build(BuildContext context) {
  //   String imageUrl = "";
  //   if (character["thumbnail"] != null) {
  //     imageUrl =
  //         '${character["thumbnail"]["path"]}/standard_fantastic.${character["thumbnail"]["extension"]}';
  //   }

  //   return GestureDetector(
  //       // When user taps this, bring up the character details.
  //       onTap: () {
  //         Navigator.push(
  //             context,
  //             new MaterialPageRoute(
  //                 builder: (context) =>
  //                     CharacterDetail(character: this.character)));
  //       },
  //       child: Card(
  //         clipBehavior: Clip.antiAlias,
  //         margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
  //         child: AspectRatio(
  //           aspectRatio: 1.0/1.0,
  //           child: Stack(
  //             children: <Widget>[
  //             Flex(direction: Axis.horizontal, children: <Widget>[
  //               Expanded(
  //                  child: Image.network(
  //                     imageUrl,
  //                     fit: BoxFit.contain,
  //                   ),
  //                 )
  //             ]),
  //             AspectRatio(
  //               aspectRatio: 4.0/1.0,
  //               child: DecoratedBox(
  //                 position: DecorationPosition.foreground,
  //                 decoration: BoxDecoration(
  //                   gradient: LinearGradient(
  //                     begin: FractionalOffset.topCenter,
  //                     end: FractionalOffset.bottomCenter,
  //                     colors: [
  //                       const Color.fromARGB(192, 0, 0, 0),
  //                       const Color.fromARGB(0, 0, 0, 0),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
  //               child: Flex(
  //                 direction: Axis.horizontal,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Expanded(
  //                     child: Text(
  //                       character["name"],
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(
  //                         color: Color.fromARGB(255, 255, 255, 255),
  //                         fontSize: 24,
  //                       ),
  //                     )
  //                   )
  //                 ],
  //               ),
  //             ),
  //             ],
  //           ),
  //         ),
  //       ));
  // }
}
