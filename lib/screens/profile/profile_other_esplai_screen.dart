import 'package:flutter/material.dart';
import 'package:gesplai/screens/profile/widgets/custom_sliver_app_bar_other.dart';
import 'package:gesplai/screens/profile/widgets/images_tab_bar.dart';
import 'package:gesplai/screens/profile/widgets/opinions_tab_bar.dart';
import 'package:gesplai/services/profile_service.dart';
import 'package:provider/provider.dart';
import 'package:gesplai/globals.dart' as globals;
import '../../models/user.dart';

class ProfileOtherEsplaiScreen extends StatefulWidget {
  final User user;
  final String idEsplai;
  const ProfileOtherEsplaiScreen(
      {Key? key, required this.user, required this.idEsplai})
      : super(key: key);

  @override
  State<ProfileOtherEsplaiScreen> createState() =>
      _ProfileOtherEsplaiScreenState();
}

class _ProfileOtherEsplaiScreenState extends State<ProfileOtherEsplaiScreen> {
  @override
  Widget build(BuildContext context) {
    final profileService = Provider.of<ProfileService>(context);
    return Scaffold(
      body: SafeArea(
          child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: globals.COLOR_LIGHT_GREY,
          body: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverAppBar(
                  flexibleSpace: CustomSliverAppBarOther(
                    user: widget.user,
                    isOther: true,
                  ),
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
            body: TabBarView(
              children: [
                widget.idEsplai == widget.user.userId
                    ? ImagesTabBar(
                        images: profileService.getEsplaiImages(),
                      )
                    : const Center(
                        child: Text(
                          "Registra't en aquest esplai per veure el contingut",
                        ),
                      ),
                const OpinionsTabBar(),
              ],
            ),
          ),
        ),
      )),
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
      color: Colors.white,
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
