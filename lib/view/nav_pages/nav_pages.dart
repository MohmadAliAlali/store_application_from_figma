import 'package:flutter/material.dart';
import 'package:task_5/controller/user_controller.dart';
import 'package:task_5/core/global_color.dart';
import 'package:task_5/core/global_text_style.dart';
import 'package:task_5/core/navigation.dart';
import 'package:task_5/core/responsiv/risponsive.dart';
import 'package:task_5/core/widget/custom_text.dart';
import 'package:task_5/core/widget/navbar.dart';
import 'package:task_5/view/favorite/favourite_screen.dart';
import 'package:task_5/view/home_screen/home_screen.dart';
import 'package:task_5/view/login_screen/login_screen.dart';
import 'package:task_5/view/my_cart_screen/my_cart_screen.dart';
import 'package:task_5/view/notfication_screen/notefication_screen.dart';
import 'package:task_5/view/profile_screen/profile_screen.dart';

class NavPages extends StatefulWidget {
  const NavPages({super.key});

  @override
  NavPagesState createState() => NavPagesState();
}

class NavPagesState extends State<NavPages> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final LoginController _userController = LoginController();

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Initialize pages and pass the drawer callback
    _pages = [
      HomeScreen(onDrawerIconPressed: _openDrawer),
      const FavouriteScreen(),
      const NoteficationScreen(),
      const ProfileScreen(),
      const MyCartScreen(),
    ];
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _closeDrawer() {
    _scaffoldKey.currentState?.closeDrawer();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        backgroundColor: const Color(0xff282828),
        width: double.infinity,
        child: ListView(
          padding: const EdgeInsets.all(36),
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 48,
                  backgroundImage:
                      AssetImage('assets/user.png') as ImageProvider,
                ),
                const SizedBox(height: 10),
                Text('Programmer X',
                    style: GlobalTextStyle.subheading
                        .copyWith(color: GlobalColor.white, fontSize: 20)),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            CustomTextDrwoer(
              text1: 'assets/icons/frame.png',
              text2: 'Profile',
              onPressed: () {
                Navigation.navigateTo(context,const ProfileScreen());
              },
            ),
            CustomTextDrwoer(
              text1: 'assets/icons/bag-2.png',
              text2: 'My Cart',
              onPressed: () {
                Navigation.navigateTo(context,const  MyCartScreen());
              },
            ),
            CustomTextDrwoer(
              text1: 'assets/icons/Path.png',
              text2: 'Favorite',
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
                _closeDrawer();
              },
            ),
            const CustomTextDrwoer(
              text1: 'assets/icons/Group.png',
              text2: 'Orders',
            ),
            CustomTextDrwoer(
              text1: 'assets/icons/Vector (3).png',
              text2: 'Notifications',
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
                _closeDrawer();
              },
            ),
            const CustomTextDrwoer(
              text1: 'assets/icons/bag-2.png',
              text2: 'Settings',
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              width: 100, // Set the width to make it a thin line
              height: 1, // Adjust the height as needed
              color: Colors.white, // Set your preferred color
            ),
            CustomTextDrwoer(
              text1: 'assets/icons/Vector (6).png',
              text2: 'Sign Out',
              onPressed: ()async{
                Future<bool> success = _userController.logout();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      await success ? 'delete success!' : 'delete have error',
                    ),
                    backgroundColor:await success ? Colors.green : Colors.red,
                    duration: const Duration(seconds: 2),
                  ),
                );
                Navigation.navigateAndRemove(context,const  LoginScreen());
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (int index) {
          if (index == 4) {
            Navigation.navigateTo(context, const MyCartScreen());
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),
    );
  }
}
