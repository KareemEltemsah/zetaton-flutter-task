import 'package:flutter/cupertino.dart';
import 'package:zetaton_flutter_task/common/constants.dart';
import 'package:zetaton_flutter_task/common/dio_helper.dart';

import 'entities/wallpaper.dart';

class SearchModel with ChangeNotifier {
  int totalResults = 0;
  List<Wallpaper> searchResult = [];

  Future<void> fetchSearchResult(String query, {int page = 1}) async {
    /// get search result
    await DioHelper.getData(
      url: '/search',
      query: {'query': query, 'per_page': perPage, 'page': page},
      token: apiKey,
    ).then((value) {
      /// reset search results list
      if (page == 1) searchResult = [];

      /// extract photos list
      var photos = (value.data['photos'] as List);

      /// add wallpapers to feeds list
      for (var photo in photos) {
        searchResult.add(Wallpaper.fromJson(photo));
      }

      /// save results count
      totalResults = value.data['total_results'];

      /// notify listeners to update search screen
      notifyListeners();
    });
  }
}
