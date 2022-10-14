import 'package:flutter/material.dart';
import 'package:gesplai/screens/profile/widgets/custom_sliver_app_bar.dart';
import 'package:gesplai/screens/profile/widgets/images_tab_bar.dart';
import 'package:gesplai/screens/profile/widgets/opinions_tab_bar.dart';
import 'package:gesplai/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:gesplai/services/profile_service.dart';

import '../../services/auth_service.dart';
import 'package:gesplai/globals.dart' as globals;
import 'package:gesplai/models/user.dart' as UserAux;

class ProfileEsplaiScreen extends StatefulWidget {
  const ProfileEsplaiScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEsplaiScreen> createState() => _ProfileEsplaiScreenState();
}

class _ProfileEsplaiScreenState extends State<ProfileEsplaiScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final profileService = Provider.of<ProfileService>(context);
    return SafeArea(
      child: FutureBuilder<UserAux.User?>(
          future: UserService.getUser(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return const Center(
                      child: Text('Something Went Wrong Try later'));
                } else {
                  final _user = snapshot.data;
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      backgroundColor: globals.COLOR_LIGHT_GREY,
                      body: NestedScrollView(
                        headerSliverBuilder: (context, isScrolled) {
                          return [
                            SliverAppBar(
                              flexibleSpace: CustomSliverAppBar(
                                user: _user,
                                isOther: false,
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
                            ImagesTabBar(
                              images: profileService.getEsplaiImages(),
                            ),
                            const OpinionsTabBar(),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            }
          }),
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
