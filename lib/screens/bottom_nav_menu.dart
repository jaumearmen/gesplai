import 'package:flutter/material.dart';
import 'package:gesplai/screens/act_not/act_not_list_screen.dart';
import 'package:gesplai/screens/attendance/calendar_screen.dart';
import 'package:gesplai/screens/chat/chat_list_screen.dart';
import 'package:gesplai/screens/profile/profile_general_screen.dart';
import 'package:gesplai/screens/search/search_screen.dart';
import 'package:gesplai/globals.dart' as globals;

class BottomNavMenu extends StatefulWidget {
  final String userId;
  const BottomNavMenu({required this.userId});

  @override
  State<BottomNavMenu> createState() => _BottomNavMenuState();
}

class _BottomNavMenuState extends State<BottomNavMenu> {
  int pageIndex = 4;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globals.COLOR_LIGHT_BLUE,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (index) => setState(() => pageIndex = index),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: globals.COLOR_WHITE,
        selectedItemColor: globals.COLOR_BLACK,
        unselectedItemColor: globals.COLOR_GREY,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined), label: 'Attendance'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'act_not'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: IndexedStack(
        index: pageIndex,
        children: [
          //AttendanceScreen2(userId: widget.userId),
          CalendarScreen(userId: widget.userId),
          SearchScreen(userId: widget.userId),
          ChatListScreen(userId: widget.userId),
          ActNotListScreen(userId: widget.userId),
          const ProfileGeneralScreen(),
        ],
      ),
    );
  }
}
