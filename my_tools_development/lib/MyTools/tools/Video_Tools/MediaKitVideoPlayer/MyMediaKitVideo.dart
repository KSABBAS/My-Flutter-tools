import 'package:flutter/material.dart';
// import 'package:media_kit/media_kit.dart';
// import 'package:media_kit_video/media_kit_video.dart';
// // import 'package:media_kit/media_kit.dart';
// // package : media_kit 1.1.11
// // ===============
// // [
// // package : media_kit_video: ^1.2.5
// // package : media_kit_libs_video: ^1.0.5
// //]
// // // add them manually to your dependencies
// // ===============
// // add : dart pub add media_kit
// // ==========================
// // you must add to the main :
// // WidgetsFlutterBinding.ensureInitialized();
// // MediaKit.ensureInitialized();
// // ==========================
// class MyMediaKitVideo extends StatefulWidget {
//   MyMediaKitVideo({
//     super.key,
//     // required this.source,
//   });
//   // String source;
//   @override
//   State<MyMediaKitVideo> createState() => _MyMediaKitVideoState();
// }

// class _MyMediaKitVideoState extends State<MyMediaKitVideo> {
//   // Create a [Player] to control playback.
//   late final player = Player();
//   // Create a [VideoController] to handle video output from [Player].
//   late final controller = VideoController(player);

//   @override
//   void initState() {
//     super.initState();
//       player.open(Media("file:///C:/Users/karee/Desktop/GitHub/My-Flutter-tools/my_tools_development/images/h.mp4"));
//   }
//   @override
//   void dispose() {
//     // Dispose of the player and controller
//     player.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Video(controller: controller);
//   }
// }