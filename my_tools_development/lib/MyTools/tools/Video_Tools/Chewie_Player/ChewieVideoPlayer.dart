import 'dart:io';

// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// // addectional package: {
// // import 'package:video_player/video_player.dart';
// // Package : video_player: ^2.9.2
// // add : flutter pub add video_player
// // }
// // import 'package:chewie/chewie.dart';
// // Package : chewie 1.8.5
// // add : flutter pub add chewie
// // ==
// // main looks like :
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   runApp(App());
// // }
// // ==
// // works on : Android
// // link type : direct mp4 link
// class ChewieVideoPlayer extends StatefulWidget {
//   ChewieVideoPlayer(
//       {super.key, this.url, this.height, this.width, this.path, this.file});

//   final double? height;
//   final double? width;
//   final String? url;
//   final String? path;
//   final File? file;

//   @override
//   State<ChewieVideoPlayer> createState() => _ChewieVideoPlayerState();
// }

// class _ChewieVideoPlayerState extends State<ChewieVideoPlayer> {
//   VideoPlayerController? _videoPlayerController;
//   ChewieController? _chewieController;

//   @override
//   void initState() {
//     super.initState();
//     _initializeVideoPlayer();
//   }

//   Future<void> _initializeVideoPlayer() async {
//     _videoPlayerController = (widget.path != null)
//         ? VideoPlayerController.asset(
//             widget.path!,
//           )
//         : (widget.file != null)
//             ? VideoPlayerController.file(widget.file!)
//             : VideoPlayerController.networkUrl(
//                 Uri.parse(widget.url ??
//                     "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"),
//               );

//     await _videoPlayerController!.initialize();

//     setState(() {
//       _chewieController = ChewieController(
//         videoPlayerController: _videoPlayerController!,
//         autoPlay: false,
//         looping: false,
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _chewieController?.dispose();
//     _videoPlayerController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_chewieController == null) {
//       return SizedBox(
//         height: widget.height ?? 235,
//         width: widget.width ?? double.infinity,
//         child: const Center(child: CircularProgressIndicator()),
//       );
//     }

//     return SizedBox(
//       height: widget.height ?? 235,
//       width: widget.width ?? double.infinity,
//       child: Chewie(controller: _chewieController!),
//     );
//   }
// }