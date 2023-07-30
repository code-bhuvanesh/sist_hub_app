import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../styles/styles.dart';

class PostImageViewer extends StatelessWidget {
  final Medium image;
  final double? height;
  final double? width;
  const PostImageViewer({
    super.key,
    required this.image,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      child: Image(
        fit: BoxFit.fitHeight,
        image: PhotoProvider(
          mediumId: image.id,
          mimeType: image.mimeType,
        ),
      ),
    );
  }
}
