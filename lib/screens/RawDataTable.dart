import 'package:feel/models/DataSetItem.dart';
import 'package:feel/models/DataSetModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class RawDataTable extends StatefulWidget {
  @override
  _RawDataTableState createState() => _RawDataTableState();
}

class _RawDataTableState extends State<RawDataTable> {
  @override
  Widget build(BuildContext context) {
    final _dataSets = Provider.of<DataSetModel>(context);

    return SingleChildScrollView(
        child: Flex(direction: Axis.vertical, children: [
      Card(
          child: DataTable(
        columnSpacing: 20.0,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Timestamp',
            ),
          ),
          DataColumn(
            numeric: true,
            label: Text(
              'Overall',
            ),
          ),
          DataColumn(
            numeric: true,
            label: Text(
              'Headache',
            ),
          ),
          DataColumn(
            numeric: true,
            label: Text(
              'Dizziness',
            ),
          ),
          DataColumn(
            numeric: true,
            label: Text(
              'Heartbeat',
            ),
          ),
          DataColumn(
            numeric: true,
            label: Text(
              'Breathing Issues',
            ),
          ),
          DataColumn(
            label: Text(
              'Activities',
            ),
          ),
          DataColumn(
            label: Text(
              '',
            ),
          ),
        ],
        rows: <DataRow>[
          for (DataSetItem dataSet in _dataSets.dataSets)
            DataRow(
              cells: <DataCell>[
                DataCell(Text(DateFormat.yMd().add_Hm().format(dataSet.time))),
                DataCell(Text(dataSet.overall.toString())),
                DataCell(Text(dataSet.headache.toString())),
                DataCell(Text(dataSet.dizziness.toString())),
                DataCell(Text(dataSet.heartbeat.toString())),
                DataCell(Text(dataSet.breathingIssues.toString())),
                DataCell(Text(dataSet.activities.toString())),
                DataCell(IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      _dataSets.removeDataSet(dataSet.id);
                    });
                  },
                ))
              ],
            ),
        ],
      ))
    ]));
  }
}
