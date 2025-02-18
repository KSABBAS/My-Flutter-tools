import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
// package : permission_handler: ^11.3.1
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sound/flutter_sound.dart';
// package : flutter_sound: ^9.0.0
  // <uses-permission android:name="android.permission.RECORD_AUDIO" />
  // <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
class SoundRecorder extends StatefulWidget {
  const SoundRecorder({
    super.key,
    this.buttonColor = Colors.blue,
    this.recordingColor = Colors.red,
    this.iconSize = 40.0,
    this.onRecordingStart,
    this.onRecordingProgress,
    this.onRecordingComplete,
    // New parameters for container decoration and icon color.
    this.containerDecoration,
    this.containerWidth,
    this.containerHeight,
    this.iconColor,
  });

  /// Background color for the button when not recording.
  final Color buttonColor;

  /// Background color for the button when recording.
  final Color recordingColor;

  /// Size of the icon.
  final double iconSize;

  /// Callback triggered when recording starts.
  final Function()? onRecordingStart;

  /// Callback triggered periodically during recording with the elapsed duration.
  final Function(Duration duration)? onRecordingProgress;

  /// Callback triggered when recording is complete, returning the audio file.
  final Function(File? audioFile)? onRecordingComplete;

  /// Optional decoration for the container wrapping the button.
  final BoxDecoration? containerDecoration;

  /// Optional width for the container.
  final double? containerWidth;

  /// Optional height for the container.
  final double? containerHeight;

  /// Optional color for the icon (overrides default white).
  final Color? iconColor;

  @override
  State<SoundRecorder> createState() => _SoundRecorderState();
}

class _SoundRecorderState extends State<SoundRecorder> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  String? _recordingPath;
  StreamSubscription? _recorderSubscription;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _initRecorder();
    } else {
      debugPrint("Audio recording is not supported on web.");
    }
  }

  Future<void> _initRecorder() async {
    try {
      await _recorder.openRecorder();
      await _recorder.setSubscriptionDuration(const Duration(milliseconds: 50));
      debugPrint("Recorder initialized successfully");
    } catch (e) {
      debugPrint("Error initializing recorder: $e");
    }
  }

  @override
  void dispose() {
    _recorderSubscription?.cancel();
    if (!kIsWeb) {
      _recorder.closeRecorder();
    }
    super.dispose();
  }

  Future<void> _startRecording() async {
    if (kIsWeb) {
      debugPrint("Audio recording is not supported on web.");
      return;
    }
    try {
      if (await Permission.microphone.request().isGranted) {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String filePath =
            '${appDocDir.path}/audio_recording_${DateTime.now().millisecondsSinceEpoch}.aac';

        await _recorder.startRecorder(
          toFile: filePath,
          codec: Codec.aacADTS,
        );
        debugPrint("Recording started, saving to $filePath");
        setState(() {
          _isRecording = true;
          _recordingPath = filePath;
        });

        widget.onRecordingStart?.call();

        _recorderSubscription = _recorder.onProgress?.listen((progress) {
          if (progress != null) {
            widget.onRecordingProgress?.call(progress.duration);
          }
        });
      } else {
        debugPrint("Microphone permission denied.");
      }
    } catch (e) {
      debugPrint("Error starting recording: $e");
    }
  }

  Future<void> _stopRecording() async {
    if (kIsWeb) {
      debugPrint("Audio recording is not supported on web.");
      return;
    }
    try {
      if (_isRecording) {
        String? resultPath = await _recorder.stopRecorder();
        _recorderSubscription?.cancel();
        _recorderSubscription = null;
        debugPrint("Recording stopped, file saved at $resultPath");

        if (resultPath != null && resultPath.isNotEmpty) {
          File audioFile = File(resultPath);
          widget.onRecordingComplete?.call(audioFile);
        }
        setState(() {
          _isRecording = false;
        });
      }
    } catch (e) {
      debugPrint("Error stopping recording: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // The button itself is animated between mic and stop icons.
    final button = AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        child: child,
      ),
      child: ElevatedButton(
        key: ValueKey<bool>(_isRecording),
        onPressed: () async {
          if (_isRecording) {
            await _stopRecording();
          } else {
            await _startRecording();
          }
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.all(widget.iconSize / 2),
          backgroundColor:
              _isRecording ? widget.recordingColor : widget.buttonColor,
        ),
        child: Icon(
          _isRecording ? Icons.stop : Icons.mic,
          size: widget.iconSize,
          color: widget.iconColor ?? Colors.white,
        ),
      ),
    );

    // Wrap the button in a container that you can customize.
    return Container(
      width: widget.containerWidth,
      height: widget.containerHeight,
      decoration: widget.containerDecoration ??
          BoxDecoration(
            color: Colors.transparent,
            gradient: const LinearGradient(
              colors: [Colors.white, Colors.white70],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(2, 2),
              )
            ],
            borderRadius: BorderRadius.circular(8),
          ),
      child: Center(child: button),
    );
  }
}
