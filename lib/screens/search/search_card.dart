import 'package:flutter/material.dart';

class SearchCard extends StatefulWidget {
  final String username;
  final AssetImage image;
  const SearchCard({Key? key, required this.username, required this.image})
      : super(key: key);

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 90,
        child: Card(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:
                      CircleAvatar(radius: 30, backgroundImage: widget.image),
                ),
                Text(widget.username),
                const SizedBox(
                  width: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
