import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemongo/pages/drives/open_drives.dart';
import 'package:pokemongo/pages/lost_and_found/lost_and_found.dart';
import 'package:pokemongo/pages/posts/normal_posts.dart';
import 'package:pokemongo/pages/problems/problems.dart';
import 'package:pokemongo/pages/upload_post/upload_post.dart';
import 'package:pokemongo/constants.dart';

class NavigationTabs extends StatefulWidget {
  const NavigationTabs({super.key});

  @override
  NavigationTabsState createState() => NavigationTabsState();
}

class NavigationTabsState extends State<NavigationTabs> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ProblemsPostsPage(),
    NormalPosts(),
    UploadPost(),
    OpenDrives(),
    LostAndFound(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: bgcolor,
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 2) {
            Get.to(() => UploadPost(), transition: Transition.rightToLeft);
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_sharp),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_sharp),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark_sharp),
            label: 'Lost & Found',
          ),
        ],
      ),
    );
  }
}
