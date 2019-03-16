import 'dart:math';
import 'dart:async';
import 'package:flutter/widgets.dart' as fw;
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:image/image.dart' as imageLib;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SafeKidLabelSmall extends pdfWidgets.Page {
  /* 
  Constructor calls super with a fixed size: 3 1/2 inches by 1.1 inches
  We set the properties as statics because I couldn't figure out how to
  set parameters in the constructor and get them into the superclass.
  */
  SafeKidLabelSmall()
      : super(
          pageFormat:
              PdfPageFormat(3.5 * PdfPageFormat.inch, 1.1 * PdfPageFormat.inch),
          build: build,
        );

  static String schoolName = "Your school's name here";
  static String schoolPhone = "Your school's phone here";
  static String kidId = "There was no ID assigned";
  static String promoText = "Get yours at SafeSchoolLabels.com!";
  //static String imageUrl = "";
  static pdfWidgets.Image heroImage;
  static PdfDocument thisPdfDocument;


  //pdfWidgets.Image img = fw.Image.network(imageUrl);

  static pdfWidgets.Widget build(pdfWidgets.Context context) {
    //var pdf = new pdfdoc
    // var img = fw.NetworkImage(
    //     'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&s=200');
    // var img = new pdfWidgets.Image(img);

    return pdfWidgets.Transform.rotate(
      angle: -90 * pi / 180,
      //transform: fw.Matrix4.rotationZ(0),
      alignment: pdfWidgets.Alignment.centerLeft,
      child: pdfWidgets.Container(
        //height: 50,
        decoration: pdfWidgets.BoxDecoration(
            border: pdfWidgets.BoxBorder(
                bottom: true, top: true, left: true, right: true)),
        padding: pdfWidgets.EdgeInsets.all(10.0),
        // pdfWidgets.BoxBorder(color: PdfColor.black, width: 2.0)),
        child: pdfWidgets.Row(children: <pdfWidgets.Widget>[
          // Superhero image goes here of ImageUrl
          heroImage,
          pdfWidgets.Column(children: <pdfWidgets.Widget>[
            pdfWidgets.Text(schoolName),
            pdfWidgets.Text(schoolPhone),
            pdfWidgets.Text(promoText),
          ]),
          // 2-D barcode goes here of KidId,
// QrImage(
//   data: "1234567890",
//   size: 200.0,
// ),
        ]),
      ),
    );
  }

  @override
  void paint(pdfWidgets.Widget child, pdfWidgets.Context context) {
    print("Calling paint");
    print("child is " + child.toString());
    super.paint(child, context);
  }
}

// Future<PdfDocument> generateDocument(PdfPageFormat format) async {
//   final PdfDoc pdf = PdfDoc();
// const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
// const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);

//   final PdfImage profileImage = await pdfImageFromImageProvider(
//       pdf: pdf.document,
//       image: fw.NetworkImage(
//           'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&s=200'),
//       onError: (dynamic exception, StackTrace stackTrace) {
//         print('error');
//       });

//   pdf.addPage(MyPage(
//     pageFormat: format.applyMargin(
//         left: 0.1 * PdfPageFormat.cm,
//         top: 0.1 * PdfPageFormat.cm,
//         right: 0.1 * PdfPageFormat.cm,
//         bottom: 0.1 * PdfPageFormat.cm),
//     build: (pdfWidgets.Context context) =>
//         pdfWidgets.Row(children: <pdfWidgets.Widget>[
//           pdfWidgets.Expanded(
//               child: pdfWidgets.Column(
//                   crossAxisAlignment: pdfWidgets.CrossAxisAlignment.start,
//                   children: <pdfWidgets.Widget>[
//                 pdfWidgets.Container(
//                     padding:
//                         const pdfWidgets.EdgeInsets.only(left: 30, bottom: 20),
//                     child: pdfWidgets.Column(
//                         crossAxisAlignment: pdfWidgets.CrossAxisAlignment.start,
//                         children: <pdfWidgets.Widget>[
//                           pdfWidgets.Text('Parnella Charlesbois',
//                               textScaleFactor: 2.0,
//                               style: pdfWidgets.Theme.of(context)
//                                   .defaultTextStyleBold),
//                           pdfWidgets.Padding(
//                               padding:
//                                   const pdfWidgets.EdgeInsets.only(top: 10)),
//                           pdfWidgets.Text('Electrotyper',
//                               textScaleFactor: 1.2,
//                               style: pdfWidgets.Theme.of(context)
//                                   .defaultTextStyleBold
//                                   .copyWith(color: green)),
//                           pdfWidgets.Padding(
//                               padding:
//                                   const pdfWidgets.EdgeInsets.only(top: 20)),
//                           pdfWidgets.Row(
//                               crossAxisAlignment:
//                                   pdfWidgets.CrossAxisAlignment.start,
//                               mainAxisAlignment:
//                                   pdfWidgets.MainAxisAlignment.spaceBetween,
//                               children: <pdfWidgets.Widget>[
//                                 pdfWidgets.Column(
//                                     crossAxisAlignment:
//                                         pdfWidgets.CrossAxisAlignment.start,
//                                     children: <pdfWidgets.Widget>[
//                                       pdfWidgets.Text(
//                                           '568 Port Washington Road'),
//                                       pdfWidgets.Text('Nordegg, AB T0M 2H0'),
//                                       pdfWidgets.Text('Canada, ON'),
//                                     ]),
//                                 pdfWidgets.Column(
//                                     crossAxisAlignment:
//                                         pdfWidgets.CrossAxisAlignment.start,
//                                     children: <pdfWidgets.Widget>[
//                                       pdfWidgets.Text('+1 403-721-6898'),
//                                       pdfWidgets.Text(
//                                           'p.charlesbois@yahoo.com'),
//                                       pdfWidgets.Text('wholeprices.ca')
//                                     ]),
//                                 pdfWidgets.Padding(
//                                     padding: pdfWidgets.EdgeInsets.zero)
//                               ]),
//                         ])),
//               ])),
//           pdfWidgets.Container(
//             height: double.infinity,
//             width: 10,
//             decoration: const pdfWidgets.BoxDecoration(
//                 border:
//                     pdfWidgets.BoxBorder(left: true, color: green, width: 2)),
//           ),
//           pdfWidgets.Column(
//               crossAxisAlignment: pdfWidgets.CrossAxisAlignment.start,
//               children: <pdfWidgets.Widget>[
//                 pdfWidgets.ClipOval(
//                     child: pdfWidgets.Container(
//                         width: 100,
//                         height: 100,
//                         color: lightGreen,
//                         child: profileImage == null
//                             ? pdfWidgets.Container()
//                             : pdfWidgets.Image(profileImage)))
//               ])
//         ]),
//   ));
//   return pdf.document;
// }
