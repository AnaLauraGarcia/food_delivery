import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/account/account_page.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/pages/cart/cart_history.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';



// https://pub.dev/packages/persistent_bottom_nav_bar


class HomePage extends StatefulWidget {
  const HomePage ({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  int _selectedIndex=0;
  late PersistentTabController _controller;

    

  // List pages=[ //01:06:55
  //   MainFoodPage(),
  //   Container(child:Center(child: Text("Next page"))),
  //   CartHistory(),
  //   AccountPage(),
  // ];

  void onTapNav(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
      return [
        MainFoodPage(),
        //SignUpPage(),
        CartHistory(),
        CartPage(),
        AccountPage(),
      ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        
          PersistentBottomNavBarItem(
              icon: Icon(CupertinoIcons.home),
              title: ("Home"),
              activeColorPrimary: CupertinoColors.systemGrey,
              inactiveColorPrimary: AppColors.mainColor,
          ),
          PersistentBottomNavBarItem(
              icon: Icon(CupertinoIcons.archivebox_fill),
              title: ("Historial"),
              activeColorPrimary: CupertinoColors.systemGrey,
              inactiveColorPrimary: AppColors.mainColor,
          ),
          PersistentBottomNavBarItem(
              icon: Icon(CupertinoIcons.cart_fill),
              title: ("Carrito"),
              activeColorPrimary: CupertinoColors.systemGrey,
              inactiveColorPrimary: AppColors.mainColor,
          ),
          PersistentBottomNavBarItem(
              icon: Icon(CupertinoIcons.person),
              title: ("User"),
              activeColorPrimary: CupertinoColors.systemGrey,
              inactiveColorPrimary: AppColors.mainColor,
          ),
      ];
  }



  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: pages[_selectedIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //       selectedItemColor: AppColors.mainColor,
  //       unselectedItemColor: Color(0xFF714031), 
  //       showSelectedLabels: false,
  //       showUnselectedLabels: false,
  //       selectedFontSize: 0.0,
  //       unselectedFontSize: 0.0,
  //       onTap: onTapNav,
  //       items: const [
  //         BottomNavigationBarItem(
  //           icon:Icon(Icons.home_outlined, ),
  //           label: "home"
  //         ),
  //         BottomNavigationBarItem(
  //           icon:Icon(Icons.archive, ),
  //           label: "history"
  //         ),       
  //         BottomNavigationBarItem(
  //           icon:Icon(Icons.home_outlined, ),
  //           label: "cart"
  //         ),       
  //         BottomNavigationBarItem(
  //           icon:Icon(Icons.person, ),
  //           label: "me"
  //         ),        
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor:  Color(0xFFFFFDF6), // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style3, // Cambiar el estilo
    );
  }
}