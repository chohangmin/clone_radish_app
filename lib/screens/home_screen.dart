import 'package:clone_radish_app/screens/home/items_page.dart';
import 'package:clone_radish_app/states/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomSelectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '홈스크린 (이태원 동)',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.list),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomSelectedIndex,
        onTap: (index) {
          setState(() {
            _bottomSelectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(_bottomSelectedIndex == 0
                ? 'assets/icons/icon_home_select.png'
                : 'assets/icons/icon_home_normal.png')),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(_bottomSelectedIndex == 1
                ? 'assets/icons/icon_location_select.png'
                : 'assets/icons/icon_location_normal.png')),
            label: "내 근처",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(_bottomSelectedIndex == 2
                ? 'assets/icons/icon_chat_select.png'
                : 'assets/icons/icon_chat_normal.png')),
            label: "채팅",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(_bottomSelectedIndex == 3
                ? 'assets/icons/icon_info_select.png'
                : 'assets/icons/icon_info_normal.png')),
            label: "내 정보",
          ),
        ],
      ),
      body: IndexedStack(
        index: _bottomSelectedIndex,
        children: [
          const ItemsPage(),
          Container(
            color: Colors.accents[1],
          ),
          Container(
            color: Colors.accents[2],
          ),
          Container(
            color: Colors.accents[3],
          )
        ],
      ),
    );
  }
}
