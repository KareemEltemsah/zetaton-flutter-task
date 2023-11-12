import 'package:flutter/cupertino.dart';
import 'package:zetaton_flutter_task/common/database_helper.dart';

import '../common/constants.dart';
import 'entities/wallpaper.dart';

class FavoritesModel with ChangeNotifier {
  List<Wallpaper> favorites = [];

  addFavorite(Wallpaper wallpaper) {
    /// add wallpaper to favorites
    DatabaseHelper.insertIntoDatabase(
        table: wallpapersTable, object: wallpaper);

    /// refresh favorites
    getFavorites();
  }

  removeFavorite(Wallpaper wallpaper) {
    /// remove wallpaper from favorites
    DatabaseHelper.removeFromDatabase(
        table: wallpapersTable, object: wallpaper);

    /// refresh favorites
    getFavorites();
  }

  getFavorites() async {
    /// get favorites wallpapers
    await DatabaseHelper.fetchTableRecords(table: wallpapersTable)
        .then((records) {
      /// add wallpapers to favorites list
      favorites = (records.map((r) => Wallpaper.fromDatabase(r))).toList();

      /// notify listeners to update favorite screen
      notifyListeners();
    });
  }
}
