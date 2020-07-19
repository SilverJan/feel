import 'package:feel/screens/AddDataSetWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppBarWidget extends StatefulWidget {
  AppBarWidget({Key key}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    AddDataSetWidget(),
    Text(
      'Index 1: Statistics',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('BottomNavigationBar Sample'),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            title: Text('Add feeling'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart),
            title: Text('Statistics'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
