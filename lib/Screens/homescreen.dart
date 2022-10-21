import 'package:calory/Screens/history.dart';
import 'package:flutter/material.dart';
import 'package:calory/Screens/Dashboard.dart';
import 'package:calory/Screens/entryscreen.dart';
import 'package:calory/Widgets/customAnimatedBottomBar.dart';
import 'package:calory/Utilities/deviceData.dart';
import 'package:calory/Utilities/constants.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        // bottomNavigationBar: navigationBar(context),
        body: SizedBox.expand(
          child: Stack(children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              children: [Dashboard(), EntryScreen(), HistoryScreen()],
            ),
            Positioned(
                top: (596 / 640) * displayHeight(context),
                child: navigationBar(context)),
          ]),
        ),
      ),
    );
  }

  Widget navigationBar(BuildContext context) {
    return customAnimatedBottomBar(
      device_hieght: displayHeight(context),
      device_width: displayWidth(context),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/fluent_home-28-regular.png',
            height: 28,
            color: Colors.black,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/jam_write.png',
            height: 28,
            color: Colors.black,
          ),
          label: 'Entry',
          // ),BottomNavigationBarItem(
          //   icon: Image.asset('assets/icons/iconoir_shop-alt.png',height: 28,color: Colors.black,),
          //   title: Text('Shop'),
          // ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.history,
            color: Colors.black,
            size: 28,
          ),
          label: 'History',
          // ),BottomNavigationBarItem(
          //   icon: Image.asset('assets/icons/iconoir_shop-alt.png',height: 28,color: Colors.black,),
          //   title: Text('Shop'),
          // ),
        )
      ],
      selected_index: selectedIndex,
      bottombaritem_selected: (index) {
        setState(() {
          selectedIndex = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 500), curve: Curves.linear);
        });
      },
    );
  }
}
