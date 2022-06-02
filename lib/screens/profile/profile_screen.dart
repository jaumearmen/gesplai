import 'package:flutter/material.dart';
import 'package:gesplai/screens/profile/images_tab_bar.dart';
import 'package:gesplai/screens/profile/opinions_tab_bar.dart';
import 'package:gesplai/screens/profile/widgets/custom_sliver_app_bar.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import 'package:gesplai/globals.dart' as globals;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: globals.COLOR_LIGHT_GREY,
          body: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return [
                const SliverAppBar(
                  flexibleSpace: CustomSliverAppBar(),
                  collapsedHeight: 380,
                  expandedHeight: 380,
                  backgroundColor: globals.COLOR_LIGHT_GREY,
                ),
                SliverPersistentHeader(
                  delegate: MyDelegate(
                    const TabBar(
                      tabs: [
                        Tab(
                          icon: Icon(
                            Icons.camera,
                            color: globals.COLOR_BLACK,
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.message,
                            color: globals.COLOR_BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                  floating: true,
                  pinned: true,
                ),
              ];
            },
            body: const TabBarView(
              children: [
                ImagesTabBar(),
                OpinionsTabBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);
  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: globals.COLOR_WHITE,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
