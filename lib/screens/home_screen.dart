import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zetaton_flutter_task/models/feed_model.dart';
import 'package:zetaton_flutter_task/widgets/wallpaper_gridview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var page = 1;
  var isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () => fetchFeeds(),
    );
  }

  /// this function will either fetch initial feeds or refresh the page
  Future<void> fetchFeeds() async {
    /// reset page number
    page = 1;

    /// enable loader
    setState(() => isLoading = true);

    /// fetch feeds
    await Provider.of<FeedModel>(context, listen: false).fetchFeeds();

    /// disable loader
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedModel>(
      builder: (context, model, child) {
        return RefreshIndicator(
          onRefresh: fetchFeeds,
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: Column(
                      children: [
                        /// wallpapers grid view
                        WallpaperGridView(wallpapers: model.feeds),

                        /// detect end of page to fetch more
                        VisibilityDetector(
                          key: const Key(''),
                          onVisibilityChanged: (info) async {
                            /// increase page number and fetch more wallpapers
                            await model.fetchFeeds(page: ++page);
                          },
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
