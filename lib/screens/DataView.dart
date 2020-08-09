import 'package:feel/common/Common.dart';
import 'package:feel/models/DataSetItem.dart';
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
    final _theme = Theme.of(context);

    return _dataSets.dataSets.length > 0
        ? Scrollbar(
            child: Container(
                color: _theme.scaffoldBackgroundColor,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                    child: ListView.builder(
                  itemBuilder: (BuildContext ctx, int i) {
                    DataSetItem dataSetItem = _dataSets.dataSets[i];

                    // if (i % 2 == 0) {
                    //   return Text("hi");
                    // }
                    return Card(
                      child: Dismissible(
                          key: ValueKey(dataSetItem.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            // color: Config.PRIMARY_COLOR,
                            child: Icon(Icons.mode_edit),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 10.0),
                          ),
                          secondaryBackground: Container(
                            color: Colors.red,
                            child: Icon(Icons.delete),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 10.0),
                          ),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              _dataSets.removeDataSet(dataSetItem.id);
                              return true;
                            } else {
                              // showDialog(
                              //     context: context,
                              //     child: AddModifyCountdownWidget(
                              //       mode: CountdownWidgetModes.modify,
                              //       selectedItem: countdown,
                              //     ));
                              return false;
                            }
                          },
                          child: ListTile(
                            title: Text(
                              "#${i} - ${formatDateTime(dataSetItem.time)}",
                              // style: TextStyle(fontSize: 18.0),
                            ),
                            subtitle: Text(dataSetItem.toString()),
                          )),
                      elevation: 2.0,
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                    );
                  },
                  itemCount: _dataSets.dataSetsList.length,
                ))))
        : Container(
            color: _theme.scaffoldBackgroundColor,
            child: Center(
                child: Text(
                    "Not data available yet. Create your first one now!")));
  }
}
