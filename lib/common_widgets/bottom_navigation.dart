import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:goferry/pages/displayFerry.dart';
import 'package:goferry/pages/order.dart';
import 'package:goferry/models/user.dart';
import 'package:goferry/pages/setting.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
    required this.user,
    this.currentPage = 0,
  }) : super(key: key);

  final User user;
  final int currentPage;

  @override
  State<BottomNavigation> createState() => _BottomNavigation();
}

class _BottomNavigation extends State<BottomNavigation> {
  final List<String> pageTitle = ["Main Menu", "Setting"];

  @override
  void iniState() {
    super.initState();
    _selectedIndex = widget.currentPage;
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      DisplayPage(user: widget.user),
      SettingPage(
        user: widget.user,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          width: 40,
          child: Image.asset("assets/logo.png"),
        ),
        // ignore: prefer_const_constructors
        bottom: PreferredSize(
          child: const Text(
            "Go Ferry",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          preferredSize: Size.zero,
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        // Display current selected bottom navbar page
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Ticket List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
