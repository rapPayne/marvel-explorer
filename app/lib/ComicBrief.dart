import 'package:flutter/material.dart';
import 'ComicDetail.dart';

class ComicBrief extends StatelessWidget {
  final dynamic comic;
  ComicBrief({this.comic});

  @override
  Widget build(BuildContext context) {
    String imageUrl = "";

    if (comic["thumbnail"] != null) {
      imageUrl =
          '${comic["thumbnail"]["path"]}/portrait_xlarge.${comic["thumbnail"]["extension"]}';
          //print("imageurl is $imageUrl");
    }
    //print(comic);
    return GestureDetector(
        // When user taps this, bring up the character details.
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                      ComicDetail(comic: this.comic)));
        },
        child: Container(
      margin: EdgeInsets.all(5),
      child: 
          Image.network(imageUrl, fit: BoxFit.contain),

    ),
    );
  }
}
