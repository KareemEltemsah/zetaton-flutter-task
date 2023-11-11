import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WallpaperCard extends StatelessWidget {
  final String wallpaperUrl;

  const WallpaperCard({super.key, required this.wallpaperUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,

      /// rounded shape
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: CachedNetworkImage(
        /// fit height, crop width if needed
        fit: BoxFit.fitHeight,
        imageUrl: wallpaperUrl,
      ),
    );
  }
}
