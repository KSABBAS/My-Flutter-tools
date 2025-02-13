import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sound/flutter_sound.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Recorder Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('Audio Recorder')),
        body: const Center(child: SoundRecorder()),
      ),
    );
  }
}

class SoundRecorder extends StatefulWidget {
  const SoundRecorder({
    super.key,
    this.buttonColor = Colors.blue,
    this.recordingColor = Colors.red,
    this.iconSize = 40.0,
    this.onRecordingStart,
    this.onRecordingProgress,
    this.onRecordingComplete,
  });

  final Color buttonColor;
  final Color recordingColor;
  final double iconSize;
  final Function()? onRecordingStart;
  final Function(Duration duration)? onRecordingProgress;
  final Function(File? audioFile)? onRecordingComplete;

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
    return AnimatedSwitcher(
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
          color: Colors.white,
        ),
      ),
    );
  }
}
