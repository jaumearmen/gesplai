import 'package:flutter/material.dart';
import 'package:gesplai/screens/search/search_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

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
                onChanged: (text) {
                  setState(() {});
                },
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: const [
                  SearchCard(
                    username: 'jaumearmen29',
                    image: AssetImage(
                      'assets/images/profileImg.jpg',
                    ),
                  ),
                  SearchCard(
                    username: 'jaumearmen123',
                    image: AssetImage(
                      'assets/images/esplai1.png',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
