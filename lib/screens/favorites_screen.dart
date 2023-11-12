import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorites_model.dart';
import '../widgets/wallpaper_gridview.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  var isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () => getFavorites(),
    );
  }

  Future<void> getFavorites() async {
    /// enable loader
    setState(() => isLoading = true);

    /// get favorites
    await Provider.of<FavoritesModel>(context, listen: false)
        .getFavorites();

    /// disable loader
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesModel>(
      builder: (context, model, child) {
        return RefreshIndicator(
          onRefresh: getFavorites,
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : model.favorites.isEmpty
                  ? const Center(
                      child: Text("No favorites"),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: Column(
                          children: [
                            /// wallpapers grid view
                            WallpaperGridView(wallpapers: model.favorites),
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
