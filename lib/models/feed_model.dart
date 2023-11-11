import 'package:flutter/cupertino.dart';
import 'package:zetaton_flutter_task/common/constants.dart';
import 'package:zetaton_flutter_task/common/dio_helper.dart';

import 'entities/wallpaper.dart';

class FeedModel with ChangeNotifier {
  List<Wallpaper> feeds = [];

  Future<void> fetchFeeds({int page = 1}) async {
    /// get home feeds (random wallpapers)
    await DioHelper.getData(
      url: '/curated',
      query: {'per_page': 30, 'page': page},
      token: apiKey,
    ).then((value) {
      /// reset feeds list
      if (page == 1) feeds = [];

      /// extract photos list
      var photos = (value.data['photos'] as List);

      /// add wallpapers to feeds list
      for (var photo in photos) {
        feeds.add(Wallpaper.fromJson(photo));
      }

      /// notify listeners to update home screen
      notifyListeners();
    });
  }
}
