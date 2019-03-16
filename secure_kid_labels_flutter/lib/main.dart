// TODO: 2D barcode scanner at https://pub.dartlang.org/documentation/barcode_scan/latest/
// TODO: Generate QR code at this API: https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=ewr2930sko234fd
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
//import 'document.dart';
import 'dart:async';
import 'SafeKidLabelSmall.dart';

//import 'package:printing_example/document.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('samples.flutter.io/battery');
  int _counter = 0;
  final GlobalKey<FormState> _key = new GlobalKey<FormState>();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Get battery level.
  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  Future<void> _printPdf() async {
    // await Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
    //   var imageUrl =
    //       "http://i.annihil.us/u/prod/marvel/i/mg/3/50/537ba56d31087/portrait_xlarge.jpg";
      PdfDoc pdf = PdfDoc();
    //   var heroImage = await _getImage(pdf, imageUrl);
      SafeKidLabelSmall.schoolName = "School name";
      SafeKidLabelSmall.schoolPhone = "972.555.2304";
      SafeKidLabelSmall.kidId = "ewr2930sko234fd";
      SafeKidLabelSmall.promoText = "Get yours at SafeSchoolLabels.com!";
      //SafeKidLabelSmall.heroImage = heroImage;
      try {
        var foo =SafeKidLabelSmall();
      pdf.addPage(foo);
      } catch (e) {
        print("$e");
      }
      // The save() brings up the dialog to choose printer
      var rawData = pdf.document.save();
      // The return brings up a print preview.
      return rawData;
    }
  

    Future<pdfWidgets.Image> _getImage(PdfDocument thisPdfDocument, imageUrl) async {

    pdfWidgets.Image heroImage;
    try {
      PdfImage pdfHeroImage = await pdfImageFromImageProvider(
        pdf: thisPdfDocument,
        image: NetworkImage(imageUrl),
      );

      heroImage = pdfWidgets.Image(pdfHeroImage);
    } catch (e) {
      print("Error! ${e.toString()}");
    }
    return heroImage;
  }
  //

  // Future<PdfDocument> _generateDocument() async {
  //   final PdfDoc pdf = PdfDoc();
  //   pdf.addPage(SafeKidLabelSmall());
  //   return pdf.document;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              child: Column(
                children: <Widget>[],
              ),
            ),
            RaisedButton(
              child: Text('Make PDF'),
              onPressed: _printPdf,
            ),
            RaisedButton(
              child: Text('Get Battery Level'),
              onPressed: _getBatteryLevel,
            ),
            Text(_batteryLevel),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
