import 'package:flutter/material.dart';
double PageHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double PageWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double? _referenceScreenWidth;

// Responsive Width Function
double ResponsiveWidth(BuildContext context, double containerWidth,
    {double? designScreenWidth = 1536}) {
  final screenWidth = MediaQuery.of(context).size.width;

  // Set the reference screen width once
  _referenceScreenWidth ??= designScreenWidth;

  // Calculate the scaling factor
  final scaleFactor = screenWidth / _referenceScreenWidth!;

  // Calculate and return the responsive width
  return containerWidth * scaleFactor;
}

double? _referenceScreenHeight;
// Responsive Height Function
double ResponsiveHeight(BuildContext context, double containerHeight,
    {double? designScreenHeight = 792}) {
  final screenHeight = MediaQuery.of(context).size.height;

  // Set the reference screen height once
  _referenceScreenHeight ??= designScreenHeight;

  // Calculate the scaling factor
  final scaleFactor = screenHeight / _referenceScreenHeight!;

  // Calculate and return the responsive height
  return containerHeight * scaleFactor;
}