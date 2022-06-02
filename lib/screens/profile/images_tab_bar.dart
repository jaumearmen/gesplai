import 'package:flutter/material.dart';
import 'package:gesplai/screens/profile/widgets/detail_image.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class ImagesTabBar extends StatefulWidget {
  const ImagesTabBar({Key? key}) : super(key: key);

  @override
  State<ImagesTabBar> createState() => _ImagesTabBarState();
}

class _ImagesTabBarState extends State<ImagesTabBar> {
  List<String> images = [
    'assets/images/esplai1.png',
    'assets/images/esplai2.jpg',
    'assets/images/esplai3.jpg',
    'assets/images/esplai4.jpg',
    'assets/images/esplai5.jpg',
    'assets/images/esplai6.jpg',
    'assets/images/esplai1.png',
    'assets/images/esplai2.jpg',
    'assets/images/esplai3.jpg',
    'assets/images/esplai4.jpg',
    'assets/images/esplai5.jpg',
    'assets/images/esplai6.jpg',
  ];

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
        itemCount: images.length,
        itemBuilder: (context, index) {
          return InkWell(
              child: Hero(
                tag: index,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(images[index]),
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.center),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailImage(
                          url: images[index],
                          index: index,
                        )));
              });
        },
      ),
    );
  }
}
