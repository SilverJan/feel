import 'package:feel/models/DataSetModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DataView extends StatefulWidget {
  @override
  _DataViewState createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {
  @override
  Widget build(BuildContext context) {
    final _dataSets = Provider.of<DataSetModel>(context);

    return ListView.builder(
      itemBuilder: (BuildContext ctx, int i) {
        return ListTile(
          title: Text("test"),
        );
      },
      itemCount: _dataSets.dataSetsList.length,
    );
  }
}
