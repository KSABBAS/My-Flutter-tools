import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';

// Enum to define the position of the timer text
enum TimerPosition { right, bottomRight }

class MyMiniAudioPlayer extends StatefulWidget {
  final String audioSource;
  final bool isAsset;
  final TimerPosition timerPosition;
  final TextStyle? timerTextStyle;
  final Color? playPauseIconColor;
  final Color? sliderActiveColor;
  final Color? sliderInactiveColor;
  final Color? sliderThumbColor;
  final Color? containerColor;
  final double? containerCircularRadius;
  final List<BoxShadow>? containerBoxShadow;
  final EdgeInsetsGeometry? containerPadding;
  final EdgeInsetsGeometry? containerMargin;
  final Alignment? containerAlignment;
  final Gradient? containerGradient;
  final DecorationImage? containerBackgroundImage;
  final BoxBorder? containerBorder;
  final double? containerHeight;
  final double? containerWidth;
  final Matrix4? containerTransform;
  final Clip? containerClipBehavior;
  final BoxShape? containerShape;

  const MyMiniAudioPlayer({
    Key? key,
    required this.audioSource,
    this.isAsset = false,
    this.timerPosition = TimerPosition.right,
    this.timerTextStyle,
    this.playPauseIconColor = Colors.blue,
    this.sliderActiveColor = Colors.blue,
    this.sliderInactiveColor = Colors.grey,
    this.sliderThumbColor = Colors.blueAccent,
    this.containerColor = Colors.white,
    this.containerCircularRadius = 12,
    this.containerBoxShadow,
    this.containerPadding,
    this.containerMargin,
    this.containerAlignment,
    this.containerGradient,
    this.containerBackgroundImage,
    this.containerBorder,
    this.containerHeight,
    this.containerWidth,
    this.containerTransform,
    this.containerClipBehavior,
    this.containerShape,
  }) : super(key: key);

  @override
  _MyMiniAudioPlayerState createState() => _MyMiniAudioPlayerState();
}

class _MyMiniAudioPlayerState extends State<MyMiniAudioPlayer> {
  late AudioPlayer _audioPlayer;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  late StreamSubscription<Duration> _positionSubscription;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        setState(() {
          _duration = duration;
        });
      }
    });

    _positionSubscription = _audioPlayer.positionStream.listen((pos) {
      setState(() {
        _position = pos;
      });
    });

    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      if (widget.isAsset) {
        await _audioPlayer.setAsset(widget.audioSource);
      } else {
        await _audioPlayer.setUrl(widget.audioSource);
      }
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  void _togglePlayPause() {
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    final timerWidget = Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        "${_formatDuration(_position)} / ${_formatDuration(_duration)}",
        style: widget.timerTextStyle ?? const TextStyle(fontSize: 12),
      ),
    );

    Widget content;
    if (widget.timerPosition == TimerPosition.right) {
      content = Row(
        children: [
          IconButton(
            icon: Icon(
              _audioPlayer.playing ? Icons.pause : Icons.play_arrow,
              size: 32,
              color: widget.playPauseIconColor,
            ),
            onPressed: _togglePlayPause,
          ),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbColor: widget.sliderThumbColor,
                activeTrackColor: widget.sliderActiveColor,
                inactiveTrackColor: widget.sliderInactiveColor,
              ),
              child: Slider(
                min: 0,
                max: _duration.inMilliseconds.toDouble(),
                value: _position.inMilliseconds.clamp(0, _duration.inMilliseconds).toDouble(),
                onChanged: (value) {
                  _audioPlayer.seek(Duration(milliseconds: value.toInt()));
                },
              ),
            ),
          ),
          timerWidget,
        ],
      );
    } else {
      content = Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  _audioPlayer.playing ? Icons.pause : Icons.play_arrow,
                  size: 32,
                  color: widget.playPauseIconColor,
                ),
                onPressed: _togglePlayPause,
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbColor: widget.sliderThumbColor,
                    activeTrackColor: widget.sliderActiveColor,
                    inactiveTrackColor: widget.sliderInactiveColor,
                  ),
                  child: Slider(
                    min: 0,
                    max: _duration.inMilliseconds.toDouble(),
                    value: _position.inMilliseconds.clamp(0, _duration.inMilliseconds).toDouble(),
                    onChanged: (value) {
                      _audioPlayer.seek(Duration(milliseconds: value.toInt()));
                    },
                  ),
                ),
              ),
            ],
          ),
          Align(alignment: Alignment.centerRight, child: timerWidget),
        ],
      );
    }

    return CMaker(
      color: widget.containerColor,
      circularRadius: widget.containerCircularRadius,
      boxShadow: widget.containerBoxShadow,
      padding: widget.containerPadding,
      margin: widget.containerMargin,
      alignment: widget.containerAlignment,
      gradient: widget.containerGradient,
      BackGroundimage: widget.containerBackgroundImage,
      border: widget.containerBorder,
      height: widget.containerHeight,
      width: widget.containerWidth,
      transform: widget.containerTransform,
      clipBehavior: widget.containerClipBehavior,
      shape: widget.containerShape,
      child: content,
    );
  }
}