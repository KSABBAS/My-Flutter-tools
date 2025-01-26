import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import : import 'package:url_launcher/url_launcher.dart';
// package : url_launcher: ^6.3.1
// add : flutter pub add url_launcher
Future<void> LaunchURL({required String url}) async {
    try {
      if (!await launchUrl(Uri.parse(url), browserConfiguration: const BrowserConfiguration(),mode: LaunchMode.platformDefault)) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      //mj
    }
  }