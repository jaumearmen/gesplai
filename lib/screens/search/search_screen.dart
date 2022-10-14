import 'package:flutter/material.dart';
import 'package:gesplai/models/user.dart';
import 'package:gesplai/screens/profile/profile_other_esplai_screen.dart';
import 'package:gesplai/screens/profile/profile_other_user_screen.dart';
import 'package:gesplai/services/user_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  List<User> _users = [];
  List<User> _allUsers = [];

  Future<void> getAllUsers() async {
    var user = await UserService.getUser();
    var users = await UserService.getAllUsers(user!.userId);
    setState(() {
      _users = users;
      _allUsers = users;
    });
  }

  @override
  void initState() {
    getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: _searchController,
                onChanged: searchUser,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 1,
                    ),
                  ),
                  hintText: 'Busca usuari',
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  final user = _users[index];
                  return ListTile(
                    leading: const Icon(
                      Icons.image,
                      size: 50,
                    ),
                    title: Text(user.username),
                    onTap: () {
                      StatefulWidget screen;
                      if (user.isEsplai) {
                        screen = ProfileOtherEsplaiScreen(
                          user: user,
                        );
                      } else {
                        screen = const ProfileOtherUserScreen();
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => screen),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  searchUser(String suggestionText) {
    final suggestions = _users.where((user) {
      final userTitle = user.username.toLowerCase();
      final input = suggestionText.toLowerCase();

      return userTitle.contains(input);
    }).toList();

    setState(() {
      _users = suggestions;
      if (suggestionText == "") _users = _allUsers;
    });
  }
}
