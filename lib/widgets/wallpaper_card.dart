import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zetaton_flutter_task/models/entities/wallpaper.dart';
import 'package:zetaton_flutter_task/screens/wallpaper_details_screen.dart';

class WallpaperCard extends StatelessWidget {
  final Wallpaper wallpaper;

  const WallpaperCard({super.key, required this.wallpaper});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WallpaperDetailsScreen(wallpaper: wallpaper),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,

        /// rounded shape
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: CachedNetworkImage(
          /// cover width and height without changed aspect ratio
          fit: BoxFit.cover,
          imageUrl: wallpaper.mediumSize!,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
