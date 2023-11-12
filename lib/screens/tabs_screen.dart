import 'package:flutter/material.dart';
import 'package:zetaton_flutter_task/screens/account_screen.dart';
import 'package:zetaton_flutter_task/screens/home_screen.dart';
import 'package:zetaton_flutter_task/screens/search_screen.dart';

import '../common/constants.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/home';

  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _pages = [
    const HomeScreen(),
    const AccountScreen(),
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() => _selectedPageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          logo,
          height: 40,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              /// navigate to search screen
              Navigator.of(context).pushNamed(SearchScreen.routeName);
            },
            icon: const Icon(
              Icons.search_outlined,
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedPageIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
