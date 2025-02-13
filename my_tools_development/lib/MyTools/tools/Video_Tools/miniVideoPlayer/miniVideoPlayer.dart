import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:video_player/video_player.dart';

/// A customizable mini video player.
///
/// Supports local or network videos with a control overlay. The bottom control
/// bar places the timer to the left, the slider in the middle, and the full‑screen
/// (or minimize) button to the right. An InkWell covering the entire area toggles
/// the controls. In full‑screen mode (if enabled), a settings icon at top right
/// toggles a small settings panel showing playback speed and quality options,
/// but only if those options are provided.
class MyMiniVideoPlayer extends StatefulWidget {
  // Video source parameters:
  final String videoSource;
  final bool isAsset;
  final Map<String, String>? qualitySources;
  final List<double>? speedOptions;

  // Container styling parameters:
  final Color? containerColor;
  final double? containerCircularRadius;
  final List<BoxShadow>? containerBoxShadow;
  final EdgeInsetsGeometry? containerPadding;
  final EdgeInsetsGeometry? containerMargin;
  final double? containerHeight;
  final double? containerWidth;
  final BoxShape? containerShape;
  final double? aspectRatio;

  // Control styling parameters:
  final Color? playPauseIconColor;
  final Color? sliderActiveColor;
  final Color? sliderInactiveColor;
  final Color? sliderThumbColor;
  final TextStyle? timerTextStyle;
  final Duration? animationDuration;

  // Control behavior and visibility:
  final Duration
      autoHideDuration; // How long controls remain visible when playing
  final bool showPlayPause;
  final bool showSlider;
  final bool showTimer;
  final bool showFullScreenButton;
  final bool showSettingsButton; // Only shown in full-screen mode
  final bool isFullScreen; // Indicates if this instance is in full-screen mode

  // Optional external controller. If provided, the widget re-uses this controller.
  final VideoPlayerController? externalController;
  // Whether to dispose the controller when this widget is disposed.
  final bool disposeController;

  const MyMiniVideoPlayer({
    Key? key,
    required this.videoSource,
    this.isAsset = false,
    this.qualitySources,
    this.speedOptions,
    // Container styling defaults:
    this.containerColor = Colors.black,
    this.containerCircularRadius = 12,
    this.containerBoxShadow,
    this.containerPadding = const EdgeInsets.all(0),
    this.containerMargin = const EdgeInsets.all(8),
    this.containerHeight,
    this.containerWidth,
    this.containerShape,
    this.aspectRatio,
    // Control styling defaults:
    this.playPauseIconColor = Colors.white,
    this.sliderActiveColor = Colors.red,
    this.sliderInactiveColor = Colors.grey,
    this.sliderThumbColor = Colors.red,
    this.timerTextStyle = const TextStyle(fontSize: 12, color: Colors.white),
    this.animationDuration = const Duration(milliseconds: 300),
    // Control behavior and visibility defaults:
    this.autoHideDuration = const Duration(seconds: 3),
    this.showPlayPause = true,
    this.showSlider = true,
    this.showTimer = true,
    this.showFullScreenButton = true,
    this.showSettingsButton = false,
    this.isFullScreen = false,
    // External controller:
    this.externalController,
    this.disposeController = true,
  }) : super(key: key);

  @override
  _MyMiniVideoPlayerState createState() => _MyMiniVideoPlayerState();
}

class _MyMiniVideoPlayerState extends State<MyMiniVideoPlayer> {
  late VideoPlayerController _controller;
  Timer? _hideTimer;
  bool _controlsVisible = true;
  bool _isPlaying = false;
  bool _settingsVisible = false; // Toggles the inline settings panel
  String _selectedQuality = '';
  double _currentSpeed = 1.0;
  bool _listenerAdded = false;

  @override
  void initState() {
    super.initState();

    // If quality sources are provided, default to the first key.
    if (widget.qualitySources != null && widget.qualitySources!.isNotEmpty) {
      _selectedQuality = widget.qualitySources!.keys.first;
    }

    // Use external controller if provided.
    if (widget.externalController != null) {
      _controller = widget.externalController!;
      _addControllerListener();
      setState(() {
        _isPlaying = _controller.value.isPlaying;
      });
      if (_isPlaying) _startHideTimer();
    } else {
      _initializeVideo();
    }
  }

  Future<void> _initializeVideo() async {
    String source = widget.videoSource;
    if (widget.qualitySources != null &&
        widget.qualitySources!.isNotEmpty &&
        _selectedQuality.isNotEmpty) {
      source = widget.qualitySources![_selectedQuality]!;
    }
    if (widget.isAsset) {
      _controller = VideoPlayerController.asset(source);
    } else {
      _controller = VideoPlayerController.network(source);
    }
    await _controller.initialize();
    _controller.setPlaybackSpeed(_currentSpeed);
    _addControllerListener();
    if (!mounted) return;
    setState(() {
      _isPlaying = _controller.value.isPlaying;
    });
    if (_isPlaying) _startHideTimer();
  }

  void _addControllerListener() {
    if (!_listenerAdded) {
      _controller.addListener(() {
        if (!mounted) return;
        setState(() {}); // Updates UI as the video position changes.
      });
      _listenerAdded = true;
    }
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    if (widget.disposeController) {
      _controller.dispose();
    }
    super.dispose();
  }

  /// Toggles play/pause. When pausing, controls remain visible.
  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      if (!mounted) return;
      setState(() {
        _isPlaying = false;
        _controlsVisible = true;
      });
      _hideTimer?.cancel();
    } else {
      _controller.play();
      if (!mounted) return;
      setState(() {
        _isPlaying = true;
      });
      _startHideTimer();
    }
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(widget.autoHideDuration, () {
      if (!mounted) return;
      if (_controller.value.isPlaying) {
        setState(() {
          _controlsVisible = false;
          _settingsVisible = false; // hide settings when auto-hiding
        });
      }
    });
  }

  /// Toggle the overall controls overlay.
  void _toggleControls() {
    if (!mounted) return;
    setState(() {
      _controlsVisible = !_controlsVisible;
      if (!_controlsVisible) _settingsVisible = false;
    });
    if (_controller.value.isPlaying && _controlsVisible) {
      _startHideTimer();
    }
  }

  /// Toggle the settings panel (only in full-screen mode).
  void _toggleSettings() {
    if (!mounted) return;
    setState(() {
      _settingsVisible = !_settingsVisible;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  /// Builds the inline settings panel if there are any options provided.
  Widget _buildSettingsPanel() {
    List<Widget> options = [];

    // Only show speed options if provided.
    if (widget.speedOptions != null && widget.speedOptions!.isNotEmpty) {
      options.add(const Text('Playback Speed',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))));
      options.add(const SizedBox(height: 4));
      options.add(Wrap(
        spacing: 8,
        children: widget.speedOptions!.map((speed) {
          return ChoiceChip(
            label: Text('${speed}x',
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
            selected: _currentSpeed == speed,
            selectedColor: Colors.redAccent,
            onSelected: (selected) {
              if (selected) {
                if (!mounted) return;
                setState(() {
                  _currentSpeed = speed;
                  _controller.setPlaybackSpeed(speed);
                });
              }
            },
          );
        }).toList(),
      ));
    }

    // Only show quality options if provided.
    if (widget.qualitySources != null && widget.qualitySources!.isNotEmpty) {
      if (options.isNotEmpty) options.add(const SizedBox(height: 12));
      options.add(const Text('Video Quality',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))));
      options.add(const SizedBox(height: 4));
      options.add(Wrap(
        spacing: 8,
        children: widget.qualitySources!.keys.map((quality) {
          return ChoiceChip(
            label: Text(quality,
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
            selected: _selectedQuality == quality ||
                (quality == 'Auto' && _selectedQuality.isEmpty),
            selectedColor: Colors.redAccent,
            onSelected: (selected) async {
              if (selected) {
                if (!mounted) return;
                setState(() {
                  _selectedQuality = quality == 'Auto' ? '' : quality;
                });
                await _controller.pause();
                await _controller.dispose();
                await _initializeVideo();
                if (_isPlaying) {
                  _controller.play();
                }
                if (!mounted) return;
                setState(() {
                  _settingsVisible = false;
                });
              }
            },
          );
        }).toList(),
      ));
    }

    if (options.isEmpty) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: options,
          ),
        ),
      ),
    );
  }


  /// Toggles full-screen mode while preserving playback state.
  Future<void> _toggleFullScreen() async {
    if (!widget.isFullScreen) {
      // Push full-screen route and await its completion.
      final VideoPlayerController? returnedController =
          await Navigator.of(context)
              .push<VideoPlayerController>(MaterialPageRoute(
        builder: (context) {
          return Scaffold(
              backgroundColor: Colors.black,
              body: SafeArea(
                  child: MyMiniVideoPlayer(
                videoSource: widget.videoSource,
                isAsset: widget.isAsset,
                qualitySources: widget.qualitySources,
                speedOptions: widget.speedOptions,
                containerColor: widget.containerColor,
                containerCircularRadius: widget.containerCircularRadius,
                containerBoxShadow: widget.containerBoxShadow,
                containerPadding: widget.containerPadding,
                containerMargin: EdgeInsets.zero,
                containerHeight: MediaQuery.of(context).size.height,
                containerWidth: MediaQuery.of(context).size.width,
                aspectRatio: widget.aspectRatio,
                playPauseIconColor: widget.playPauseIconColor,
                sliderActiveColor: widget.sliderActiveColor,
                sliderInactiveColor: widget.sliderInactiveColor,
                sliderThumbColor: widget.sliderThumbColor,
                timerTextStyle: widget.timerTextStyle,
                animationDuration: widget.animationDuration,
                autoHideDuration: widget.autoHideDuration,
                showPlayPause: widget.showPlayPause,
                showSlider: widget.showSlider,
                showTimer: widget.showTimer,
                showFullScreenButton: widget.showFullScreenButton,
                showSettingsButton:
                    widget.showSettingsButton, // Enable settings in full-screen mode.
                isFullScreen: true,
                // Re-use the same controller so playback continues seamlessly.
                externalController: _controller,
                disposeController: false,
              )));
        },
      ));
      await _controller.dispose();
      await _initializeVideo();
      _controller.seekTo(returnedController!.value.position);
      returnedController.dispose();
    } else {
      Navigator.of(context).pop(_controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    final videoAspectRatio = widget.aspectRatio ??
        (_controller.value.isInitialized
            ? _controller.value.aspectRatio
            : 16 / 9);

    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: widget.containerHeight,
        width: widget.containerWidth,
        margin: widget.containerMargin,
        padding: widget.containerPadding,
        decoration: BoxDecoration(
          color: widget.containerColor,
          borderRadius:
              BorderRadius.circular(widget.containerCircularRadius ?? 0),
          boxShadow: widget.containerBoxShadow,
          shape: widget.containerShape ?? BoxShape.rectangle,
        ),
        child: Stack(
          children: [
            // Video display.
            Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: videoAspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : const CircularProgressIndicator(),
            ),
            // InkWell over the entire area to toggle controls.
            InkWell(
              onTap: _toggleControls,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.transparent,
              ),
            ),
            // Controls overlay.
            if (_controlsVisible && _controller.value.isInitialized)
              Positioned.fill(
                child: Container(
                  color: Colors.black38,
                  child: Stack(
                    children: [
                      // Another InkWell to ensure taps toggle the controls.
                      InkWell(
                        onTap: _toggleControls,
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.transparent,
                        ),
                      ),
                      // Center play/pause button.
                      if (widget.showPlayPause)
                        Center(
                          child: IconButton(
                            iconSize: 64,
                            icon: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_filled,
                              color: widget.playPauseIconColor,
                            ),
                            onPressed: _togglePlayPause,
                          ),
                        ),
                      // Bottom control bar.
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          color: Colors.black54,
                          child: Row(
                            children: [
                              // Timer on the left.
                              if (widget.showTimer)
                                Text(
                                  '${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}',
                                  style: widget.timerTextStyle,
                                ),
                              if (widget.showSlider) const SizedBox(width: 8),
                              // Slider in the middle.
                              if (widget.showSlider)
                                Expanded(
                                  child: Slider(
                                    min: 0,
                                    max: _controller
                                        .value.duration.inMilliseconds
                                        .toDouble(),
                                    value: _controller
                                        .value.position.inMilliseconds
                                        .clamp(
                                          0,
                                          _controller
                                              .value.duration.inMilliseconds,
                                        )
                                        .toDouble(),
                                    activeColor: widget.sliderActiveColor,
                                    inactiveColor: widget.sliderInactiveColor,
                                    thumbColor: widget.sliderThumbColor,
                                    onChanged: (value) {
                                      _controller.seekTo(Duration(
                                          milliseconds: value.toInt()));
                                      if (!mounted) return;
                                      setState(() {
                                        _controlsVisible = true;
                                      });
                                    },
                                  ),
                                ),
                              // Full-screen/minimize button on the right.
                              if(widget.showFullScreenButton)IconButton(
                                icon: Icon(
                                  widget.isFullScreen
                                      ? Icons.fullscreen_exit
                                      : Icons.fullscreen,
                                  color: widget.playPauseIconColor,
                                ),
                                onPressed: _toggleFullScreen,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // In full-screen mode, show a settings icon at the top right.
                      if (widget.isFullScreen&&widget.showSettingsButton)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Icon(Icons.settings,
                                color: widget.playPauseIconColor),
                            onPressed: _toggleSettings,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            // The settings panel overlay (only in full-screen and when toggled on).
            if (widget.isFullScreen&&
                widget.showSettingsButton &&
                _settingsVisible)
              _buildSettingsPanel(),
          ],
        ),
      ),
    );
  }
}
