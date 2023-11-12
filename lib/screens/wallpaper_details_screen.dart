import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_flutter_task/models/entities/wallpaper.dart';
import 'package:zetaton_flutter_task/models/favorites_model.dart';

import '../common/tools.dart';

class WallpaperDetailsScreen extends StatefulWidget {
  final Wallpaper wallpaper;

  const WallpaperDetailsScreen({super.key, required this.wallpaper});

  @override
  State<WallpaperDetailsScreen> createState() => _WallpaperDetailsScreenState();
}

class _WallpaperDetailsScreenState extends State<WallpaperDetailsScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onDoubleTap: () {
          /// already favorite
          if (isFavorite) return;

          /// double tap to favorite
          Provider.of<FavoritesModel>(context, listen: false)
              .addFavorite(widget.wallpaper);
          setState(() => isFavorite = true);
        },
        child: Stack(
          children: [
            /// wallpaper
            CachedNetworkImage(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              imageUrl: widget.wallpaper.largeSize!,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
            ),

            /// buttons
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.2,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    /// favorite button
                    Consumer<FavoritesModel>(
                      builder: (context, value, child) {
                        /// check if it's favorite wallpaper
                        isFavorite =
                            Provider.of<FavoritesModel>(context, listen: false)
                                .favorites
                                .any((e) => e.id == widget.wallpaper.id);
                        return IconButton(
                          /// tap will trigger the opposite status
                          onPressed: () {
                            if (isFavorite) {
                              /// remove favorite
                              Provider.of<FavoritesModel>(context,
                                      listen: false)
                                  .removeFavorite(widget.wallpaper);
                            } else {
                              /// add favorite
                              Provider.of<FavoritesModel>(context,
                                      listen: false)
                                  .addFavorite(widget.wallpaper);
                            }
                            setState(() => isFavorite = !isFavorite);
                          },
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            size: 30,
                            color: isFavorite ? Colors.red : Colors.white,
                          ),
                        );
                      },
                    ),

                    /// download button
                    IconButton(
                      /// save image
                      onPressed: () => saveImage(context),
                      icon: const Icon(
                        Icons.download,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// this function will download the image to the gallery
  saveImage(context) async {
    try {
      /// get image as bytes
      var response = await Dio().get(widget.wallpaper.originalSize!,
          options: Options(responseType: ResponseType.bytes));

      /// save image to device
      await ImageGallerySaver.saveImage(Uint8List.fromList(response.data),
          quality: 60, name: widget.wallpaper.id.toString());

      /// successful
      Tools.showSnackBar(context, 'Image Downloaded');
    } catch (e) {
      /// failed
      Tools.showSnackBar(context, 'Failed to download image');
    }
  }
}
