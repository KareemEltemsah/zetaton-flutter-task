import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_flutter_task/common/database_helper.dart';
import 'package:zetaton_flutter_task/models/favorites_model.dart';
import 'package:zetaton_flutter_task/models/search_model.dart';
import 'package:zetaton_flutter_task/models/user_model.dart';
import 'package:zetaton_flutter_task/screens/search_screen.dart';
import 'package:zetaton_flutter_task/screens/tabs_screen.dart';
import 'package:zetaton_flutter_task/screens/user/login_screen.dart';
import 'package:zetaton_flutter_task/screens/user/register_screen.dart';

import 'common/cache_helper.dart';
import 'common/dio_helper.dart';
import 'models/feed_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// init firebase
  await Firebase.initializeApp();

  /// init Dio helper
  DioHelper.init();

  /// init cache helper
  await CacheHelper.init();

  /// init local db helper
  await DatabaseHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(create: (_) => UserModel()),
        ChangeNotifierProvider<FeedModel>(create: (_) => FeedModel()),
        ChangeNotifierProvider<SearchModel>(create: (_) => SearchModel()),
        ChangeNotifierProvider<FavoritesModel>(create: (_) => FavoritesModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Task',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: Consumer<UserModel>(
          builder: (context, model, child) {
            /// check is user is not logged in
            if (model.user == null) return LoginScreen();

            /// user logged in
            return const TabsScreen();
          },
        ),
        routes: {
          TabsScreen.routeName: (ctx) => const TabsScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          RegisterScreen.routeName: (ctx) => RegisterScreen(),
          SearchScreen.routeName: (ctx) => const SearchScreen(),
        },
      ),
    );
  }
}
