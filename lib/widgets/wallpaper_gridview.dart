import 'package:flutter/cupertino.dart';
import 'package:zetaton_flutter_task/widgets/wallpaper_card.dart';

import '../models/entities/wallpaper.dart';

class WallpaperGridView extends StatelessWidget {
  final List<Wallpaper> wallpapers;

  const WallpaperGridView({super.key, required this.wallpapers});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: wallpapers.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 2 / 3,
      ),
      itemBuilder: (BuildContext context, int index) {
        return WallpaperCard(wallpaperUrl: wallpapers[index].mediumSize!);
      },
    );
  }
}
