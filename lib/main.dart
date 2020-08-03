import 'package:feel/models/DataSetItem.dart';
import 'package:feel/models/DataSetModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/AppBarWidget.dart';

void main() => runApp(Feel());

class Feel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<DataSetModel>.value(value: DataSetModel()),
          Provider.value(value: DataSetItemProperties())
        ],
        child: MaterialApp(
          home: AppBarWidget(),
          themeMode: ThemeMode.dark,
          theme: ThemeData(
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
        ));
  }
}
