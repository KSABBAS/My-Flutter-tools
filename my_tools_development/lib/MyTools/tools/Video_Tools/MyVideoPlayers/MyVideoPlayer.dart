import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:my_tools_development/MyTools/Functions/Height_and_width_Functions.dart';
// import 'package:my_tools_development/MyTools/tools/CMaker_Tools/AnimatedCMaker.dart';
// import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
// import 'package:my_tools_development/MyTools/tools/Text_Tools/TMaker.dart';
// // import 'package:video_player/video_player.dart';
// // package : video_player: ^2.9.2;
// // add : flutter pub add video_player
// import 'dart:io';
// // import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// import 'package:video_player/video_player.dart';

// class MyVideoPlayer extends StatefulWidget {
//   MyVideoPlayer({
//     super.key,
//     this.url,
//     this.height,
//     this.width,
//     this.allowFullScreen = true,
//     this.allowSettings = false,
//     this.asset,
//     this.uri,
//     this.file,
//     this.autoPlay = false,
//     this.showPlayPauseButton = true,
//     this.showProgressBar = true,
//     this.showVolumeControl = true,
//     this.isFullScreen = false, // New parameter
//   });

//   final String? url;
//   final Uri? uri;
//   final String? asset;
//   final double? height;
//   final double? width;
//   final File? file;
//   final bool allowFullScreen;
//   final bool allowSettings;
//   final bool autoPlay;
//   final bool showPlayPauseButton;
//   final bool showProgressBar;
//   final bool showVolumeControl;
//   final bool isFullScreen; // New property

//   @override
//   State<MyVideoPlayer> createState() => _MyVideoPlayerState();
// }

// class _MyVideoPlayerState extends State<MyVideoPlayer> {
//   VideoPlayerController? _controller;
//   bool _isInitializing = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _initializeController();
//   }

//   bool _isYoutubeUrl(String url) {
//     return url.contains('youtube.com') || url.contains('youtu.be');
//   }

//   Future<void> _initializeController() async {
//     try {
//       setState(() => _isInitializing = true);
      
//       // if (widget.url != null) {
//       //   if (_isYoutubeUrl(widget.url!)) {
//       //     print("Detected YouTube URL: ${widget.url}");
          
//       //     final yt = YoutubeExplode();
//       //     try {
//       //       final video = await yt.videos.get(widget.url!);
//       //       final manifest = await yt.videos.streamsClient.getManifest(video.id);
            
//       //       // Get only MP4 streams
//       //       final streams = manifest.muxed.where((stream) => 
//       //         stream.container.name.toLowerCase() == 'mp4'
//       //       ).toList();
            
//       //       if (streams.isEmpty) throw Exception('No MP4 stream found');
            
//       //       // Get medium quality MP4
//       //       final streamInfo = streams.firstWhere(
//       //         (stream) => stream.videoQuality.name.contains('360'),
//       //         orElse: () => streams.first
//       //       );
            
//       //       final videoUrl = streamInfo.url.toString();
//       //       print("Stream type: ${streamInfo.container.name}");
//       //       print("Quality: ${streamInfo.videoQuality.name}");
//       //       print("Video URL: $videoUrl");
            
//       //       _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
//       //     } catch (e) {
//       //       print("YouTube extraction error: $e");
//       //       throw Exception("Failed to extract YouTube video: $e");
//       //     } finally {
//       //       yt.close();
//       //     }
//       //   } else {
//       //     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url!));
//       //   }
        
//       //   await _controller!.initialize();
//       //   if (widget.autoPlay) {
//       //     await _controller!.play();
//       //   }
//       // }
      
//     } catch (error) {
//       print("Controller initialization error: $error");
//       _errorMessage = 'Failed to load video: $error';
//     } finally {
//       setState(() => _isInitializing = false);
//     }
//   }

//   @override
//   void dispose() {
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//     _controller?.pause();
//     _controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isInitializing) {
//       return Center(child: CircularProgressIndicator());
//     }
    
//     if (_errorMessage != null) {
//       return Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(Icons.error_outline, color: Colors.red, size: 48),
//             SizedBox(height: 8),
//             Text(_errorMessage!, style: TextStyle(color: Colors.red)),
//           ],
//         ),
//       );
//     }
    
//     return ACMaker(
//       duration: Duration(milliseconds: 300),
//       height: widget.height ?? 200,
//       width: widget.width ?? MediaQuery.of(context).size.width,
//       color: Colors.black,
//       child: Stack(
//         children: [
//           Center(child: _controller != null 
//             ? _VideoPlayer(controller: _controller!)
//             : CircularProgressIndicator()),
//           _Controls(
//             controller: _controller!,
//             onChange: (newController) {
//               _controller = newController;
//             },
//             allowSettings: widget.allowSettings,
//             allowFullScreen: widget.allowFullScreen,
//             showPlayPauseButton: widget.showPlayPauseButton,
//             showProgressBar: widget.showProgressBar,
//             onScreenModeChange: (fullScreen) {
//               if (fullScreen) {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) {
//                     return Scaffold(
//                       body: Stack(
//                         children: [
//                           Center(
//                             child: _VideoPlayer(controller: _controller!),
//                           ),
//                           CMaker(
//                             height: PageHeight(context),
//                             width: PageWidth(context),
//                             child: _Controls(
//                               controller: _controller!,
//                               onChange: (newController) {
//                                 _controller = newController;
//                               },
//                               allowFullScreen: widget.allowFullScreen,
//                               showPlayPauseButton: widget.showPlayPauseButton,
//                               showProgressBar: widget.showProgressBar,
//                               onScreenModeChange: (fullScreen) {
//                                 Navigator.of(context).pop();
//                               },
//                               allowSettings: widget.allowSettings,
//                               showVolumeControl: widget.showVolumeControl,
//                               isFullScreen: widget.isFullScreen,
//                             ),
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 ));
//               }
//             },
//             showVolumeControl: widget.showVolumeControl,
//             isFullScreen: widget.isFullScreen,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _Controls extends StatefulWidget {
//   final VideoPlayerController controller;
//   final Function(VideoPlayerController) onChange;
//   final bool allowSettings;
//   final bool allowFullScreen;
//   final bool showPlayPauseButton;
//   final bool showProgressBar;
//   final bool showVolumeControl;
//   final Function(bool) onScreenModeChange;
//   final bool isFullScreen; // New parameter

//   const _Controls({
//     required this.controller,
//     required this.onChange,
//     required this.allowSettings,
//     required this.allowFullScreen,
//     required this.showPlayPauseButton,
//     required this.showProgressBar,
//     required this.showVolumeControl,
//     required this.onScreenModeChange,
//     required this.isFullScreen, // New parameter
//   });

//   @override
//   __ControlsState createState() => __ControlsState();
// }

// class __ControlsState extends State<_Controls> {
//   bool fullScreenIsOn = false;
//   bool isMuted = false;
//   final ValueNotifier<bool> _isPlaying = ValueNotifier<bool>(false);
//   double _currentVolume = 1.0;

//   @override
//   Widget build(BuildContext context) {
//     bool isFullScreen = MediaQuery.of(context).orientation == Orientation.landscape;

//     return (!widget.controller.value.isInitialized)
//         ? Center(
//             child: CircularProgressIndicator(
//             color: Colors.white,
//           ))
//         : AnimatedOpacity(
//             opacity: widget.controller.value.isPlaying ? 0 : 1,
//             duration: Duration(milliseconds: 300),
//             child: CMaker(
//               padding: EdgeInsets.symmetric(vertical: 5),
//               color: const Color.fromARGB(100, 52, 52, 52),
//               height: 200,
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   if (isFullScreen && widget.allowSettings)
//                     Expanded(
//                       child: CMaker(
//                         padding: EdgeInsets.all(10),
//                         child: Row(
//                           children: [
//                             Spacer(),
//                             CMaker(
//                               width: 40,
//                               height: 40,
//                               child: IconButton(
//                                   onPressed: () {},
//                                   icon: Icon(
//                                     Icons.settings,
//                                     color: Colors.white,
//                                     size: 20,
//                                   )),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   if (widget.showPlayPauseButton)
//                     Expanded(
//                       flex: 4,
//                       child: Center(
//                         child: IconButton(
//                           icon: Icon(
//                             widget.controller.value.isPlaying
//                                 ? Icons.pause
//                                 : Icons.play_arrow,
//                             color: Colors.white,
//                             size: 50,
//                           ),
//                           onPressed: () {
//                             widget.controller.value.isPlaying
//                                 ? widget.controller.pause()
//                                 : widget.controller.play();
//                             widget.onChange(widget.controller);
//                             setState(() {});
//                           },
//                         ),
//                       ),
//                     ),
//                   if (widget.showProgressBar)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           TMaker(
//                             fontWeight: FontWeight.w400,
//                             text: '${_formatDuration(widget.controller.value.position)} / ${_formatDuration(widget.controller.value.duration)}',
//                             fontSize: 12,
//                             color: Colors.white,
//                           ),
//                           SizedBox(height: 2),
//                           VideoProgressIndicator(
//                             widget.controller,
//                             allowScrubbing: true,
//                             colors: VideoProgressColors(
//                               playedColor: Colors.red,
//                               bufferedColor: Colors.grey,
//                               backgroundColor: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       if (isFullScreen && widget.showVolumeControl) // Added isFullScreen condition
//                         CMaker(
//                           width: 40,
//                           height: 40,
//                           child: IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 isMuted = !isMuted;
//                                 if (isMuted) {
//                                   widget.controller.setVolume(0);
//                                 } else {
//                                   widget.controller.setVolume(1);
//                                 }
//                               });
//                             },
//                             icon: Icon(
//                               isMuted ? Icons.volume_off : Icons.volume_up,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                       if (widget.allowFullScreen)
//                         CMaker(
//                           width: 40,
//                           height: 40,
//                           child: IconButton(
//                             onPressed: () {
//                               if (!widget.isFullScreen) {
//                                 SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//                                 SystemChrome.setPreferredOrientations([
//                                   DeviceOrientation.landscapeLeft,
//                                   DeviceOrientation.landscapeRight,
//                                 ]);
//                               } else {
//                                 SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//                                 SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//                               }
//                               widget.onScreenModeChange(!widget.isFullScreen);
//                             },
//                             icon: Icon(
//                               (!widget.isFullScreen)
//                                   ? Icons.fullscreen
//                                   : Icons.fullscreen_exit,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                   GestureDetector(
//                     onVerticalDragUpdate: (details) {
//                       if (!widget.showVolumeControl) return;
                      
//                       setState(() {
//                         // Convert drag to volume change (-0.01 per pixel)
//                         _currentVolume -= details.delta.dy * 0.01;
//                         // Clamp volume between 0 and 1
//                         _currentVolume = _currentVolume.clamp(0.0, 1.0);
//                         widget.controller.setVolume(_currentVolume);
//                       });
//                     },
//                     child: CMaker(
//                       width: 40,
//                       height: 40,
//                       child: IconButton(
//                         onPressed: () {
//                           setState(() {
//                             isMuted = !isMuted;
//                             if (isMuted) {
//                               widget.controller.setVolume(0);
//                             } else {
//                               widget.controller.setVolume(1);
//                             }
//                           });
//                         },
//                         icon: Icon(
//                           isMuted ? Icons.volume_off : Icons.volume_up,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                   ),
//                   RawKeyboardListener(
//                     focusNode: FocusNode(),
//                     onKey: (event) {
//                       if (event is RawKeyDownEvent) {
//                         if (event.logicalKey == LogicalKeyboardKey.space) {
//                           // Play/Pause
//                           widget.controller.value.isPlaying 
//                             ? widget.controller.pause() 
//                             : widget.controller.play();
//                         } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
//                           // Seek backward
//                           final newPosition = widget.controller.value.position - Duration(seconds: 5);
//                           widget.controller.seekTo(newPosition);
//                         } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
//                           // Seek forward
//                           final newPosition = widget.controller.value.position + Duration(seconds: 5);
//                           widget.controller.seekTo(newPosition);
//                         }
//                       }
//                     },
//                     child: Container(), // Replace with your actual controls widget
//                   ),
//                 ],
//               ),
//             ));
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
//   }
// }

// class _VideoPlayer extends StatelessWidget {
//   final VideoPlayerController controller;
//   _VideoPlayer({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onDoubleTapDown: (details) {
//         final screenWidth = context.size!.width;
//         final tapPosition = details.globalPosition.dx;
        
//         // Seek forward if tap is on right side, backward if on left
//         if (tapPosition < screenWidth / 2) {
//           final newPosition = controller.value.position - Duration(seconds: 10);
//           controller.seekTo(newPosition);
//         } else {
//           final newPosition = controller.value.position + Duration(seconds: 10);
//           controller.seekTo(newPosition);
//         }
//       },
//       child: AspectRatio(
//         aspectRatio: controller.value.aspectRatio,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             VideoPlayer(controller),
//             if (controller.value.isBuffering)
//               CircularProgressIndicator(color: Colors.white),
//           ],
//         ),
//       ),
//     );
//   }
// }