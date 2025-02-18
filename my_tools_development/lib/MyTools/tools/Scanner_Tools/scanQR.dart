import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// package: mobile_scanner: ^6.0.2
// add: flutter pub add mobile_scanner

// Future<String> scanQR(BuildContext context) async {
//   // Using Completer to handle the async flow properly
//   final Completer<String> completer = Completer<String>();
//   await Navigator.of(context).push(MaterialPageRoute(
//     builder: (context) {
//       return scanQRWidget(
//         onScanned: (result) {
//           completer.complete(result); // Complete only when we have a confirmed result
//         },
//       );
//     },
//   ));

//   // Wait for the completer to complete before returning
//   return await completer.future;
// }

// class scanQRWidget extends StatelessWidget {
//   const scanQRWidget({super.key, required this.onScanned});
//   final Function(String result) onScanned;

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope( // Prevent accidental back navigation
//       onWillPop: () async {
//         // Show confirmation dialog before allowing back navigation
//         final bool? shouldPop = await showDialog<bool>(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('إلغاء المسح؟'),
//             content: Text('هل أنت متأكد أنك تريد إلغاء عملية المسح؟'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   onScanned("no result"); // Return no result if user confirms cancel
//                   Navigator.pop(context, true); // Close dialog with true
//                 },
//                 child: Text('نعم'),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pop(context, false), // Close dialog with false
//                 child: Text('لا'),
//               ),
//             ],
//           ),
//         );
//         return shouldPop ?? false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('مسح رمز QR'),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () async {
//               // Show the same confirmation dialog when back button is pressed
//               final bool? shouldPop = await showDialog<bool>(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: Text('إلغاء المسح؟'),
//                   content: Text('هل أنت متأكد أنك تريد إلغاء عملية المسح؟'),
//                   actions: [
//                     TextButton(
//                       onPressed: () {
//                         onScanned("no result");
//                         Navigator.pop(context, true);
//                       },
//                       child: Text('نعم'),
//                     ),
//                     TextButton(
//                       onPressed: () => Navigator.pop(context, false),
//                       child: Text('لا'),
//                     ),
//                   ],
//                 ),
//               );
//               if (shouldPop ?? false) {
//                 Navigator.pop(context);
//               }
//             },
//           ),
//         ),
//         body: MobileScanner(
//           onDetect: (capture) {
//             final List<Barcode> barcodes = capture.barcodes;
//             if (barcodes.isNotEmpty && barcodes[0].rawValue != null) {
//               String scannedValue = barcodes[0].rawValue.toString();
//               onScanned(scannedValue); // Set the scan result
//                               Navigator.pop(context); // Close dialog
//             }
//           },
//         ),
//       ),
//     );
//   }
// }