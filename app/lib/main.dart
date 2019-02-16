import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'globalConstants.dart';
import 'AdmobAdvertisements.dart';
import 'MainPage.dart';
import 'CharacterQuery.dart';
import 'CharacterList.dart';
import 'ComicsList.dart';
import 'Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  MyApp() {
    analytics.logAppOpen();
    FirebaseAdMob.instance.initialize(appId: androidAdmobAppId);
    myBanner
  // typically this happens well before the ad is shown
  ..load()
  ..show(
    // Positions the banner ad 60 pixels from the bottom of the screen
    anchorOffset: 60.0,
    // Banner Position
    anchorType: AnchorType.bottom,
  );
  print("got here");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // TODO: RAP - These routes are not being used properly. Refactor later.
      initialRoute: "MainPage",
      navigatorObservers: <NavigatorObserver>[observer],
      routes: <String, WidgetBuilder>{
        "CharacterQuery": (BuildContext context) => CharacterQuery(),
        "CharacterList": (BuildContext context) => CharacterList(),
        "ComicsList": (BuildContext context) => ComicsList(),
        "Login": (BuildContext context) => Login(),
        "MainPage": (BuildContext context) => MainPage(),
      },
      title: 'Marvel Comics Lookup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CharacterQuery(),
    );
  }
}
