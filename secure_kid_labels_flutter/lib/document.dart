// This is just an example document. Maybe like a format?

import 'dart:async';

import 'package:flutter/widgets.dart' as fw;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:printing/printing.dart';
import 'SafeKidLabelSmall.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);

// class MyPage extends pdfWidgets.Page {
//   MyPage(
//       {PdfPageFormat pageFormat,
//       pdfWidgets.BuildCallback build,
//       pdfWidgets.EdgeInsets margin})
//       : super(pageFormat: pageFormat, margin: margin, build: build) {
//         print("Creating MyPage...");
//     if (pageFormat == null) 
//     pageFormat = new PdfPageFormat(100, 100);
//   }

//   @override
//   void paint(pdfWidgets.Widget child, pdfWidgets.Context context) {
//     context.canvas
//       // ..setColor(lightGreen)
//       // ..moveTo(0, pageFormat.height)
//       // ..lineTo(0, pageFormat.height - 230)
//       // ..lineTo(60, pageFormat.height)
//       // ..fillPath()
//       // ..setColor(green)
//       // ..moveTo(0, pageFormat.height)
//       // ..lineTo(0, pageFormat.height - 100)
//       // ..lineTo(100, pageFormat.height)
//       // ..fillPath()
//       // ..setColor(lightGreen)
//       // ..moveTo(30, pageFormat.height)
//       // ..lineTo(110, pageFormat.height - 50)
//       // ..lineTo(150, pageFormat.height)
//       // ..fillPath()
//       // ..moveTo(pageFormat.width, 0)
//       // ..lineTo(pageFormat.width, 230)
//       // ..lineTo(pageFormat.width - 60, 0)
//       // ..fillPath()
//       // ..setColor(green)
//       // ..moveTo(pageFormat.width, 0)
//       // ..lineTo(pageFormat.width, 100)
//       // ..lineTo(pageFormat.width - 100, 0)
//       // ..fillPath()
//       // ..setColor(lightGreen)
//       // ..moveTo(pageFormat.width - 30, 0)
//       // ..lineTo(pageFormat.width - 110, 50)
//       // ..lineTo(pageFormat.width - 150, 0)
//       ..fillPath();

//     super.paint(child, context);
//   }
// }

// class Block extends pdfWidgets.StatelessWidget {
//   Block({this.title});

//   final String title;

//   @override
//   pdfWidgets.Widget build(pdfWidgets.Context context) {
//     return pdfWidgets.Column(
//         crossAxisAlignment: pdfWidgets.CrossAxisAlignment.start,
//         children: <pdfWidgets.Widget>[
//           pdfWidgets.Row(
//               crossAxisAlignment: pdfWidgets.CrossAxisAlignment.start,
//               children: <pdfWidgets.Widget>[
//                 pdfWidgets.Container(
//                   width: 6,
//                   height: 6,
//                   margin: const pdfWidgets.EdgeInsets.only(
//                       top: 2.5, left: 2, right: 5),
//                   decoration: const pdfWidgets.BoxDecoration(
//                       color: green, shape: pdfWidgets.BoxShape.circle),
//                 ),
//                 pdfWidgets.Text(title,
//                     style: pdfWidgets.Theme.of(context).defaultTextStyleBold),
//               ]),
//           pdfWidgets.Container(
//             decoration: const pdfWidgets.BoxDecoration(
//                 border:
//                     pdfWidgets.BoxBorder(left: true, color: green, width: 2)),
//             padding:
//                 const pdfWidgets.EdgeInsets.only(left: 10, top: 5, bottom: 5),
//             margin: const pdfWidgets.EdgeInsets.only(left: 5),
//             child: pdfWidgets.Column(
//                 crossAxisAlignment: pdfWidgets.CrossAxisAlignment.start,
//                 children: <pdfWidgets.Widget>[
//                   pdfWidgets.Lorem(length: 20),
//                 ]),
//           ),
//         ]);
//   }
// }

// class Category extends pdfWidgets.StatelessWidget {
//   Category({this.title});

//   final String title;

//   @override
//   pdfWidgets.Widget build(pdfWidgets.Context context) {
//     return pdfWidgets.Container(
//         decoration:
//             const pdfWidgets.BoxDecoration(color: lightGreen, borderRadius: 6),
//         margin: const pdfWidgets.EdgeInsets.only(bottom: 10, top: 20),
//         padding: const pdfWidgets.EdgeInsets.fromLTRB(10, 7, 10, 4),
//         child: pdfWidgets.Text(title, textScaleFactor: 1.5));
//   }
// }

Future<PdfDocument> generateDocument(PdfPageFormat format) async {
  final PdfDoc pdf = PdfDoc();

  // final PdfImage profileImage = await pdfImageFromImageProvider(
  //     pdf: pdf.document,
  //     image: fw.NetworkImage(
  //         'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&s=200'),
  //     onError: (dynamic exception, StackTrace stackTrace) {
  //       print('error');
  //     });

  // pdf.addPage(MyPage(
  //   pageFormat: format.applyMargin(
  //       left: 0.1 * PdfPageFormat.cm,
  //       top: 0.1 * PdfPageFormat.cm,
  //       right: 0.1 * PdfPageFormat.cm,
  //       bottom: 0.1 * PdfPageFormat.cm),
  //   build: (pdfWidgets.Context context) =>
  //       pdfWidgets.Row(children: <pdfWidgets.Widget>[
  //         pdfWidgets.Expanded(
  //             child: pdfWidgets.Column(
  //                 crossAxisAlignment: pdfWidgets.CrossAxisAlignment.start,
  //                 children: <pdfWidgets.Widget>[
  //               pdfWidgets.Container(
  //                   padding:
  //                       const pdfWidgets.EdgeInsets.only(left: 30, bottom: 20),
  //                   child: pdfWidgets.Column(
  //                       crossAxisAlignment: pdfWidgets.CrossAxisAlignment.start,
  //                       children: <pdfWidgets.Widget>[
  //                         pdfWidgets.Text('Parnella Charlesbois',
  //                             textScaleFactor: 2.0,
  //                             style: pdfWidgets.Theme.of(context)
  //                                 .defaultTextStyleBold),
  //                         pdfWidgets.Padding(
  //                             padding:
  //                                 const pdfWidgets.EdgeInsets.only(top: 10)),
  //                         pdfWidgets.Text('Electrotyper',
  //                             textScaleFactor: 1.2,
  //                             style: pdfWidgets.Theme.of(context)
  //                                 .defaultTextStyleBold
  //                                 .copyWith(color: green)),
  //                         pdfWidgets.Padding(
  //                             padding:
  //                                 const pdfWidgets.EdgeInsets.only(top: 20)),
  //                         pdfWidgets.Row(
  //                             crossAxisAlignment:
  //                                 pdfWidgets.CrossAxisAlignment.start,
  //                             mainAxisAlignment:
  //                                 pdfWidgets.MainAxisAlignment.spaceBetween,
  //                             children: <pdfWidgets.Widget>[
  //                               pdfWidgets.Column(
  //                                   crossAxisAlignment:
  //                                       pdfWidgets.CrossAxisAlignment.start,
  //                                   children: <pdfWidgets.Widget>[
  //                                     pdfWidgets.Text(
  //                                         '568 Port Washington Road'),
  //                                     pdfWidgets.Text('Nordegg, AB T0M 2H0'),
  //                                     pdfWidgets.Text('Canada, ON'),
  //                                   ]),
  //                               pdfWidgets.Column(
  //                                   crossAxisAlignment:
  //                                       pdfWidgets.CrossAxisAlignment.start,
  //                                   children: <pdfWidgets.Widget>[
  //                                     pdfWidgets.Text('+1 403-721-6898'),
  //                                     pdfWidgets.Text(
  //                                         'p.charlesbois@yahoo.com'),
  //                                     pdfWidgets.Text('wholeprices.ca')
  //                                   ]),
  //                               pdfWidgets.Padding(
  //                                   padding: pdfWidgets.EdgeInsets.zero)
  //                             ]),
  //                       ])),
  //               Category(title: 'Work Experience'),
  //               Block(title: 'Tour bus driver'),
  //               Block(title: 'Logging equipment operator'),
  //               Block(title: 'Podiatrist'),
  //               Category(title: 'Education'),
  //               Block(title: 'BS Of Commerce'),
  //               Block(title: 'BS Interior Design'),
  //             ])),
  //         pdfWidgets.Container(
  //           height: double.infinity,
  //           width: 10,
  //           decoration: const pdfWidgets.BoxDecoration(
  //               border:
  //                   pdfWidgets.BoxBorder(left: true, color: green, width: 2)),
  //         ),
  //         pdfWidgets.Column(
  //             crossAxisAlignment: pdfWidgets.CrossAxisAlignment.start,
  //             children: <pdfWidgets.Widget>[
  //               pdfWidgets.ClipOval(
  //                   child: pdfWidgets.Container(
  //                       width: 100,
  //                       height: 100,
  //                       color: lightGreen,
  //                       child: profileImage == null
  //                           ? pdfWidgets.Container()
  //                           : pdfWidgets.Image(profileImage)))
  //             ])
  //       ]),
  // ));
  pdf.addPage(SafeKidLabelSmall());
  return pdf.document;
}
