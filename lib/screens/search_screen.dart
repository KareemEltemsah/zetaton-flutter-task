import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zetaton_flutter_task/models/search_model.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/wallpaper_gridview.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  var page = 1;
  var isLoading = false;
  var showSearchResult = false;

  Future<void> fetchSearchResults() async {
    /// reset page number
    page = 1;

    /// enable loader
    setState(() {
      isLoading = true;
      showSearchResult = true;
    });

    /// fetch search results
    await Provider.of<SearchModel>(context, listen: false)
        .fetchSearchResult(searchController.text);

    /// disable loader
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search for wallpapers',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 20),
          child: Column(
            children: [
              /// search field
              CustomTextField(
                autofocus: true,
                controller: searchController,
                type: TextInputType.text,
                hint: 'Search',
                onChange: (String value) {
                  if (value.trim().isEmpty) {
                    setState(() => showSearchResult = false);
                    return;
                  }
                  fetchSearchResults();
                },
              ),
              const SizedBox(height: 10),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : showSearchResult
                      ? Consumer<SearchModel>(
                          builder: (context, model, child) {
                            /// save search results to local variable
                            final searchResult = model.searchResult;

                            if (searchResult.isEmpty) {
                              /// in case there is no results
                              /// for user's search query
                              return const Center(
                                child: Text("No results"),
                              );
                            }

                            /// search results exist
                            return Column(
                              children: [
                                /// wallpapers grid view
                                WallpaperGridView(wallpapers: searchResult),

                                if (searchResult.length < model.totalResults)

                                  /// detect end of page to fetch more
                                  VisibilityDetector(
                                    key: const Key(''),
                                    onVisibilityChanged: (info) async {
                                      /// increase page number and fetch more wallpapers
                                      /// with the same search query
                                      await model.fetchSearchResult(
                                          searchController.text,
                                          page: ++page);
                                    },
                                    child: const Center(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  )
                              ],
                            );
                          },
                        )
                      : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
