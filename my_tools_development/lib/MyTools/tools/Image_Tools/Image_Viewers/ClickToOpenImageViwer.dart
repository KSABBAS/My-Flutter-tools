import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
// import 'package:insta_image_viewer/insta_image_viewer.dart';
// package: insta_image_viewer 1.0.4
// add : flutter pub add insta_image_viewer

class ClickToOpenImageViwer extends StatelessWidget {
  const ClickToOpenImageViwer(
      {super.key,
      this.ImageLink,
      this.ImagePath,
      this.file,
      this.bytes,
      this.Height,
      this.Width,
      this.borderRadius});
  final String? ImageLink;
  final String? ImagePath;
  final File? file;
  final Uint8List? bytes;
  final double? Height;
  final double? Width;
  final BorderRadius? borderRadius;
  @override
  Widget build(BuildContext context) {
    if (ImagePath != null &&
        ImageLink == null &&
        file == null &&
        bytes == null) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        child: SizedBox(
          width: Width ?? 100,
          height: Height ?? 100,
          child: InstaImageViewer(
            child: Image(
              image: Image.asset(ImagePath!).image,
            ),
          ),
        ),
      );
    } else if (ImageLink == null && file != null && bytes == null) {
      return ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          child: SizedBox(
            width: Width ?? double.infinity,
            height: Height ?? double.infinity,
            child: InstaImageViewer(
              child: Image(
                image: Image.file(file!).image,
              ),
            ),
          ));
    } else if (ImageLink == null && bytes != null) {
      return ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          child: SizedBox(
            width: Width ?? double.infinity,
            height: Height ?? double.infinity,
            child: InstaImageViewer(
              child: Image(
                image: Image.memory(bytes!).image,
              ),
            ),
          ));
    } else {
      return ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          child: SizedBox(
            width: Width ?? double.infinity,
            height: Height ?? double.infinity,
            child: InstaImageViewer(
              child: Image(
                image: Image.network(
                        ImageLink ?? "https://picsum.photos/id/507/1000")
                    .image,
              ),
            ),
          ));
    }
  }
}