import 'package:feel/common/Config.dart';
import 'package:flutter/material.dart';

import 'screens/AppBarWidget.dart';

void main() => runApp(Feel());

class Feel extends StatelessWidget {
  static const String _title = Config.APP_NAME;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: AppBarWidget(),
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
    );
  }
}
