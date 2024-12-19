import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/manager/bottom_navigation_manager.dart';
import 'package:cost_share/presentation/common/avatar.dart';
import 'package:cost_share/presentation/common/background_icon.dart';
import 'package:cost_share/presentation/common/group_card.dart';
import 'package:cost_share/presentation/home/home_screen.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(
        mainScaffoldKey: scaffoldKey,
      ),
      Center(child: Text("Transaction Screen")),
      Center(child: Text("Add Screen")),
      Center(child: Text("Budget Screen")),
      Center(child: Text("Member Screen")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        extendBody: true,
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // User Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Avatar(
                      size: 80,
                      border: 0,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Username',
                      style: AppTextStyles.title2
                          .copyWith(color: AppColors.colorDark75),
                    ),
                    Text(
                      'Username@gmail.com',
                      style: AppTextStyles.body3
                          .copyWith(color: AppColors.colorLight20),
                    )
                  ],
                ),
                Divider(
                  indent: 12,
                  endIndent: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Groups",
                          style: AppTextStyles.title2
                              .copyWith(color: AppColors.colorDark25)),
                      GestureDetector(
                        onTap: () {},
                        child: Assets.icon.svg.iconAdd.svg(),
                      )
                    ],
                  ),
                ),
                // List of Groups
                Expanded(
                  child: ListView.builder(
                    itemCount: 10, // Replace with dynamic group count
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        child: GroupCard(
                            member: 5,
                            authorName: 'authorName',
                            cardState: CardState.active),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                ListTile(
                  leading: BackgroundIcon(
                    icon: Assets.icon.svg.iconSettings.svg(
                        colorFilter: ColorFilter.mode(
                            AppColors.colorViolet100, BlendMode.srcIn)),
                    backgroundColor: AppColors.colorViolet40,
                  ),
                  title: Text("Logout"),
                ),
                Divider(
                  indent: 12,
                  endIndent: 12,
                ),
                ListTile(
                  leading: BackgroundIcon(
                    icon: Assets.icon.svg.iconLogout.svg(
                        colorFilter: ColorFilter.mode(
                            AppColors.colorRed100, BlendMode.srcIn)),
                    backgroundColor: AppColors.colorRed20,
                  ),
                  title: Text("Logout"),
                ),
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
        body: Consumer<BottomNavigationManager>(
          builder: (context, value, child) => _screens[value.selectedTabIndex],
        ),
        floatingActionButton: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.colorViolet100,
            ),
            child: Assets.icon.svg.iconAdd.svg(
                height: 30,
                width: 30,
                colorFilter: ColorFilter.mode(
                    AppColors.colorLight100, BlendMode.srcIn))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Consumer<BottomNavigationManager>(
          builder: (context, value, child) {
            return BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 8.0,
              child: Container(
                height: 60,
                child: Row(
                  children: [
                    _bottomBarItem(Assets.icon.svg.iconHome.path,
                        context.localization.home, value, 0),
                    _bottomBarItem(Assets.icon.svg.iconTransaction.path,
                        context.localization.transaction, value, 1),
                    SizedBox(
                      width: 100,
                    ),
                    _bottomBarItem(Assets.icon.svg.iconPieChart.path,
                        context.localization.budget, value, 2),
                    _bottomBarItem(Assets.icon.svg.iconUser.path,
                        context.localization.member, value, 3),
                  ],
                ),
              ),
            );
          },
        ));
  }

  onTap(value) async {
    Provider.of<BottomNavigationManager>(context, listen: false)
        .updateTabIndex(value);
  }

  Widget _bottomBarItem(
      String icon, String label, BottomNavigationManager value, int index) {
    return FilledButton(
      onPressed: () => onTap(index),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero,
        shadowColor: Colors.transparent,
        minimumSize: Size(0, 48),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              height: 32,
              width: 32,
              colorFilter: ColorFilter.mode(
                  value.selectedTabIndex == index
                      ? AppColors.colorViolet100
                      : AppColors.colorLight10,
                  BlendMode.srcIn),
            ),
            Text(
              label,
              style: AppTextStyles.tiny.copyWith(
                color: value.selectedTabIndex == index
                    ? AppColors.colorViolet100
                    : AppColors.colorLight10,
              ),
            )
          ],
        ),
      ),
    );
  }
}