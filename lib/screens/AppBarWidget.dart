import 'package:feel/models/DataSetModel.dart';
import 'package:feel/screens/AddDataSetWidget.dart';
import 'package:feel/screens/DataView.dart';
import 'package:feel/screens/RawDataTable.dart';
import 'package:feel/screens/SettingsWidget.dart';
import 'package:feel/screens/Statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatefulWidget {
  AppBarWidget({Key key}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  int _selectedIndex = 0;

  static const channel = const MethodChannel('myWatchChannel');

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
    try {
      final _dataSets = Provider.of<DataSetModel>(context);
      var amount = 0;
      if (_dataSets.dataSets != null) {
        amount = _dataSets.dataSets.length;
      }
      channel.invokeMethod("sendStringToNative", amount.toString());
    } catch (e) {
      print("An error occured while sending data to Apple Watch: $e");
    }

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
