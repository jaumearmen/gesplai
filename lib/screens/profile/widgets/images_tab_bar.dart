import 'package:flutter/material.dart';
import 'package:gesplai/screens/profile/widgets/detail_image.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class ImagesTabBar extends StatefulWidget {
  final List<String> images;
  const ImagesTabBar({Key? key, required this.images}) : super(key: key);

  @override
  State<ImagesTabBar> createState() => _ImagesTabBarState();
}

class _ImagesTabBarState extends State<ImagesTabBar> {
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;

    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
        ),
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          return InkWell(
              child: Hero(
                tag: index,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(widget.images[index]),
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.center),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailImage(
                          url: widget.images[index],
                          index: index,
                        )));
              });
        },
      ),
    );
  }
}
