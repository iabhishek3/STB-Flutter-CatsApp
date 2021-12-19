import 'package:flutter/material.dart';
import 'package:stb_cat_app/features/presentation/screens/saved_cats.dart';

import 'new_cat.dart';

class CatHome extends StatefulWidget {
   CatHome({Key? key}) : super(key: key);


  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    List<Widget> _widgetOptions = <Widget>[
      NewCat(),
      SavedCats()


  ];

  @override
  State<CatHome> createState() => _CatHomeState();
}

class _CatHomeState extends State<CatHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget._widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Cat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download_for_offline_rounded),
            label: 'Downloaded',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo,
        onTap: _onItemTapped,
      ),
    );
  }
}
