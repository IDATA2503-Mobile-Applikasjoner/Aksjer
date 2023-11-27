import 'package:flutter/material.dart';
import 'package:aksje_app/widgets/screens/inventory.dart';
import 'package:aksje_app/widgets/screens/my_lists.dart';
import 'package:aksje_app/widgets/screens/explore.dart';
import 'package:aksje_app/widgets/components/navigation_bar.dart';

//global variabel used for outer widgets to set a index that the page wants to navigatges to.
int _selectedIndex = 0;

//Represent main page
//The nav bar is used here to set page
//The Main page switches between Inventory, MyListPage and Explore Page
class MainPage extends StatefulWidget {
  final int selectedIndex;

  const MainPage({Key? key, required this.selectedIndex}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const List<Widget> _pages = <Widget>[
    Inventory(),
    MyListsPage(),
    ExplorePage(),
  ];

  //Set a new index when taping on the nav bar.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
