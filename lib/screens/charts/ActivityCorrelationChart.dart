import 'dart:collection';

import 'package:feel/models/DataSetItem.dart';
import 'package:feel/models/DataSetModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ActivityCorrelationChart extends StatefulWidget {
  @override
  _ActivityCorrelationChartState createState() =>
      _ActivityCorrelationChartState();
}

class _ActivityCorrelationChartState extends State<ActivityCorrelationChart> {
  @override
  Widget build(BuildContext context) {
    final _dataSets = Provider.of<DataSetModel>(context);

    // Step 1) Get dataSetItems with low / high overall values
    List<DataSetItem> _dataSetsWithHighOverall = _dataSets.dataSets
        .where((DataSetItem item) =>
            item != null && item.overall >= 3.667 ? true : false)
        .toList();

    List<DataSetItem> _dataSetsWithLowOverall = _dataSets.dataSets
        .where((DataSetItem item) => item.overall < 1.667 ? true : false)
        .toList();

    // Step 2) Get all activities for selected dataSetItems
    List<String> activitiesInHighOverall = [];
    List<String> activitiesInLowOverall = [];

    _dataSetsWithHighOverall.forEach((e) {
      activitiesInHighOverall.addAll(e.activities);
    });

    _dataSetsWithLowOverall.forEach((e) {
      activitiesInLowOverall.addAll(e.activities);
    });

    // Step 3) Get occurences of activities
    var highOverallActivitiesMap = Map<String, int>();
    var lowOverallActivitiesMap = Map<String, int>();
    activitiesInHighOverall.forEach((activity) =>
        highOverallActivitiesMap[activity] =
            !highOverallActivitiesMap.containsKey(activity)
                ? (1)
                : (highOverallActivitiesMap[activity] + 1));

    activitiesInLowOverall.forEach((activity) =>
        lowOverallActivitiesMap[activity] =
            !lowOverallActivitiesMap.containsKey(activity)
                ? (1)
                : (lowOverallActivitiesMap[activity] + 1));

    // Step 4) Sort based on highest occurences
    var sortedKeys = highOverallActivitiesMap.keys.toList(growable: false)
      ..sort((k2, k1) =>
          highOverallActivitiesMap[k1].compareTo(highOverallActivitiesMap[k2]));
    highOverallActivitiesMap = new Map.fromIterable(sortedKeys,
        key: (k) => k, value: (k) => highOverallActivitiesMap[k]);

    sortedKeys = lowOverallActivitiesMap.keys.toList(growable: false)
      ..sort((k2, k1) =>
          lowOverallActivitiesMap[k1].compareTo(lowOverallActivitiesMap[k2]));
    lowOverallActivitiesMap = new Map.fromIterable(sortedKeys,
        key: (k) => k, value: (k) => lowOverallActivitiesMap[k]);

    // Step 5) Create string to be printed
    String highMapString = "";
    for (var i = 0; i < highOverallActivitiesMap.length; i++) {
      highMapString +=
          "${i + 1}) ${highOverallActivitiesMap.keys.toList()[i]} (${highOverallActivitiesMap.values.toList()[i]} times)\n";
      if (i == 2) {
        break;
      }
    }

    String lowMapString = "";
    for (var i = 0; i < lowOverallActivitiesMap.length; i++) {
      lowMapString +=
          "${i + 1}) ${lowOverallActivitiesMap.keys.toList()[i]} (${lowOverallActivitiesMap.values.toList()[i]} times)\n";
      if (i == 2) {
        break;
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text("Activities while having bad overall health"),
          subtitle: Text(highMapString),
        ),
        Divider(),
        ListTile(
          title: Text("Activities while having good overall health"),
          subtitle: Text(lowMapString),
        )
      ],
    );
  }
}
