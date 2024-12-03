import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
//===========================================
// import 'package:geolocator/geolocator.dart';
// package : geolocator 13.0.2
// add : flutter pub add geolocator
// ==
// android
// -in the gradle.properties place
//   android.useAndroidX=true
//   android.enableJetifier=true
// -in the android/app/build.gradle
//   make sure that compileSdkVersion 34
// -in the AndroidManifest.xml
//   place these Permissions
//     <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
//     <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
//     <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />

// ==
// -main looks like
// List<String> PositionList = ["latitude", "longitude"];
// Position? PosVar;
// final LocationSettings locationSettings = LocationSettings(
//   accuracy: LocationAccuracy.best,
//   distanceFilter: 100,
// );
// StreamSubscription<Position> positionStream =
//     Geolocator.getPositionStream().listen((Position? position) {
//   PositionList = [
//     "${position!.latitude.toString()}",
//     "${position.longitude.toString()}"
//   ];
//   PosVar = position;
// });
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   GetLocationPermmision();
//   runApp(App());
// }
// ==

GetLocationPermmision() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  }
}

//===========================================

//----------------------------------------------------------

//===========================================

// bool IsConnectedToInternet() {
//   Future<bool> check() async {
//     var state = await Connectivity().checkConnectivity();
//     print(state.first);
//     return state.first.toString() == "ConnectivityResult.none";
//   }
//   return true;
// }

//===========================================

//----------------------------------------------------------

// ===========================================
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as Parser;
// import 'package:html/dom.dart' as dom;
// import 'package:html/dom_parsing.dart';
// import 'package:html/html_escape.dart';


// // Future<List> ScrapeByClass(String link, String tag, String class_) async {
// //   String html = "";
////   List result = [];
////   http.Response t = await http.get(Uri.parse(link));
////   html = dom.Document.html(t.body).outerHtml;
////   BeautifulSoup soup = BeautifulSoup(html);
////   for (var vercs in soup.findAll(tag, class_: class_)) {
////     result.add(vercs.text);
////   }
////   return result;
//// }
//// ===========================================

// ----------------------------------------------------------

//===========================================
// import 'package:flutter/material.dart';

double PageHeight(BuildContext context) {
  List l = [2.2];
  final Sheigt = MediaQuery.of(context).size.height;
  l.add(Sheigt);
  return l[1];
}

double PageWidth(BuildContext context) {
  List l = [2.2];
  final Swidth = MediaQuery.of(context).size.width;
  l.add(Swidth);
  return l[1];
}

//===========================================

//----------------------------------------------------------

//===========================================

// List<Widget>? WidgetListMaker(int number, Widget widget) {
//   List<Widget>? list = [];
//   for (int i = 0; i < number; i++) {
//     list.add(widget);
//   }
//   return list;
// }

//===========================================

//----------------------------------------------------------

//===========================================

// import 'package:image_picker/image_picker.dart';
// package : image_picker: ^1.1.2
// in terminal : flutter pub add image_picker
Future PickImageFromGalary() async {
  return await ImagePicker().pickImage(source: ImageSource.gallery);
}
Future PickImageFromCamera() async {
  return await ImagePicker().pickImage(source: ImageSource.camera);
}
Future PickVideoFromCamera() async {
  return await ImagePicker().pickVideo(source: ImageSource.camera);
}
Future PickVideoFromGalary() async {
  return await ImagePicker().pickVideo(source: ImageSource.gallery);
}
Future PickPhotoMultiImageFromGalary() async {
  return await ImagePicker().pickMultiImage();
}
Future PickMediaFromGalary() async {
  return await ImagePicker().pickMedia();
}
Future PickMultiMediaFromGalary() async {
  return await ImagePicker().pickMultipleMedia();
}

//===========================================

//----------------------------------------------------------

//===========================================



//===========================================

//----------------------------------------------------------

//===========================================



//===========================================

//----------------------------------------------------------

//===========================================



//===========================================

//----------------------------------------------------------









