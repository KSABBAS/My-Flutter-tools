import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

// MyConnectivityWrapper Widget - Core component that checks connectivity across all platforms
class MyConnectivityWrapper extends StatefulWidget {
  final Widget child;
  final Color overlayColor;
  final double blurAmount;
  final Color messageBackgroundColor;
  final Color messageTextColor;
  final Color buttonColor;
  final Color buttonTextColor;
  final String noConnectionMessage;
  final String buttonText;
  final double borderRadius;
  final EdgeInsets messagePadding;
  final VoidCallback? onButtonPressed;
  final bool showButton;

  const MyConnectivityWrapper({
    Key? key,
    required this.child,
    this.overlayColor = Colors.black54,
    this.blurAmount = 5.0,
    this.messageBackgroundColor = Colors.white,
    this.messageTextColor = Colors.black87,
    this.buttonColor = Colors.blue,
    this.buttonTextColor = Colors.white,
    this.noConnectionMessage = 'No Internet Connection',
    this.buttonText = 'Try Again',
    this.borderRadius = 8.0,
    this.messagePadding = const EdgeInsets.all(24.0),
    this.onButtonPressed,
    this.showButton = true,
  }) : super(key: key);

  @override
  State<MyConnectivityWrapper> createState() => My_ConnectivityWrapperState();
}

class My_ConnectivityWrapperState extends State<MyConnectivityWrapper> {
  bool _isConnected = true;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _checkInitialConnectivity();
    _setupConnectivityListener();
  }

  Future<void> _checkInitialConnectivity() async {
    try {
      final List<ConnectivityResult> results = await Connectivity().checkConnectivity();
      setState(() {
        _isConnected = !results.contains(ConnectivityResult.none) && results.isNotEmpty;
      });
    } catch (e) {
      // Handle potential errors on platforms that might not fully support connectivity_plus
      setState(() {
        _isConnected = true; // Default to true to avoid blocking the UI on unsupported platforms
      });
    }
  }

  void _setupConnectivityListener() {
    try {
      _connectivitySubscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
        setState(() {
          _isConnected = !results.contains(ConnectivityResult.none) && results.isNotEmpty;
        });
      });
    } catch (e) {
      // Handle potential errors on platforms that might not fully support connectivity_plus
      // Just continue without the listener
    }
  }

  @override
  void dispose() {
    try {
      _connectivitySubscription.cancel();
    } catch (e) {
      // Ignore errors during cleanup
    }
    super.dispose();
  }

  // Cross-platform handling for when the button is pressed
  Future<void> _handleButtonPress() async {
    // If custom handler is provided, use it
    if (widget.onButtonPressed != null) {
      widget.onButtonPressed!();
      return;
    }

    // Otherwise attempt to open relevant settings based on platform
    final platform = Theme.of(context).platform;
    
    try {
      if (platform == TargetPlatform.android) {
        await _openAndroidSettings();
      } else if (platform == TargetPlatform.iOS) {
        await _openIOSSettings();
      } else {
        // For other platforms, simply refresh connectivity check
        await _checkInitialConnectivity();
      }
    } catch (e) {
      // Fallback - just check connectivity again
      await _checkInitialConnectivity();
    }
  }

  Future<void> _openAndroidSettings() async {
    try {
      await const MethodChannel('app.channel.shared.intent').invokeMethod('openSettings');
    } catch (e) {
      // Fallback for Android
      final Uri url = Uri.parse('package:com.android.settings');
      if (await url_launcher.canLaunchUrl(url)) {
        await url_launcher.launchUrl(url);
      }
    }
  }

  Future<void> _openIOSSettings() async {
    try {
      await const MethodChannel('app.channel.shared.intent').invokeMethod('openSettings');
    } catch (e) {
      // Fallback for iOS - open the Settings app URL scheme if possible
      final Uri url = Uri.parse('App-Prefs:root=WIFI');
      if (await url_launcher.canLaunchUrl(url)) {
        await url_launcher.launchUrl(url);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (!_isConnected)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: widget.blurAmount, sigmaY: widget.blurAmount),
            child: Container(
              color: widget.overlayColor,
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24.0),
                  padding: widget.messagePadding,
                  decoration: BoxDecoration(
                    color: widget.messageBackgroundColor,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.wifi_off, size: 48),
                      const SizedBox(height: 16),
                      Text(
                        widget.noConnectionMessage,
                        style: TextStyle(
                          color: widget.messageTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Please check your connection and try again',
                        style: TextStyle(
                          color: widget.messageTextColor.withOpacity(0.8),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      if (widget.showButton)
                        ElevatedButton(
                          onPressed: _handleButtonPress,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.buttonColor,
                            foregroundColor: widget.buttonTextColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(widget.borderRadius),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: Text(widget.buttonText),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}