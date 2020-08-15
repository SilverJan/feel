import 'package:feel/screens/AddDataSetWidget.dart';
import 'package:feel/screens/DataView.dart';
import 'package:feel/screens/RawDataTable.dart';
import 'package:feel/screens/SettingsWidget.dart';
import 'package:feel/screens/Statistics.dart';
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
    Statistics(),
    DataView(),
    // SettingsWidget()
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
      // backgroundColor: Colors.black,
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            title: Text('Add data set'),
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.pie_chart),
            // icon: Icon(Icons.poll),
            icon: Icon(Icons.show_chart),
            title: Text('Statistics'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart),
            title: Text('Raw data'),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings),
          //   title: Text('Settings'),
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        backgroundColor: Theme.of(context).cardTheme.color,
      ),
    );
  }
}
