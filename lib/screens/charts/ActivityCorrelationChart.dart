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
  DataSetModel _dataSets;
  DataSetItemProperties dataSetItemProperties;
  DataSetItemProperty selectedProperty;

  @override
  Widget build(BuildContext context) {
    _dataSets = Provider.of<DataSetModel>(context);
    final dataSetItemProperties = Provider.of<DataSetItemProperties>(context);
    final _formKey = GlobalKey<FormState>();

    // Set initial selected property to first (overall)
    if (selectedProperty == null) {
      selectedProperty = dataSetItemProperties.allProperties[0];
    }

    // Create dropdown menu items for selection
    List<DropdownMenuItem<DataSetItemProperty>> dropdownMenuItems = [];
    dataSetItemProperties.allProperties.forEach((element) {
      dropdownMenuItems.add(DropdownMenuItem(
        child: Text(element.niceName),
        value: element,
      ));
    });

    // Get strings which will be shown in view later on
    List<String> correlationsStrings = getCorrelationStrings(selectedProperty);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Form(
              key: _formKey,
              child: DropdownButtonFormField<DataSetItemProperty>(
                value: selectedProperty,
                onChanged: (value) {
                  setState(() {
                    selectedProperty = value;
                  });
                },
                items: dropdownMenuItems,
                decoration: const InputDecoration(
                    labelText: "Choose property to get correlation to"),
              ),
            )),
        Divider(),
        ListTile(
          title: Text(
              "Activities where '${selectedProperty.niceName}' was rated bad"),
          subtitle: Text(correlationsStrings[0]),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        ),
        Divider(),
        ListTile(
          title: Text(
              "Activities where '${selectedProperty.niceName}' was rated good"),
          subtitle: Text(correlationsStrings[1]),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        )
      ],
    );
  }

  List<String> getCorrelationStrings(DataSetItemProperty property) {
    // Step 1) Get dataSetItems with low / high overall values
    List<DataSetItem> _dataSetsWithHighOverall = _dataSets.dataSets
        .where((DataSetItem item) => item.toJson()[property.name] != null &&
                double.tryParse(item.toJson()[property.name].toString()) >=
                    3.667
            ? true
            : false)
        .toList();

    List<DataSetItem> _dataSetsWithLowOverall = _dataSets.dataSets
        .where((DataSetItem item) => item.toJson()[property.name] != null &&
                double.tryParse(item.toJson()[property.name].toString()) < 1.667
            ? true
            : false)
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
    if (highOverallActivitiesMap.length == 0) {
      highMapString = "n.a.";
    }
    for (var i = 0; i < highOverallActivitiesMap.length; i++) {
      highMapString +=
          "${i + 1}) ${highOverallActivitiesMap.keys.toList()[i]} (${highOverallActivitiesMap.values.toList()[i]} times)\n";
      // stop at top 3
      if (i == 2) {
        break;
      }
    }

    String lowMapString = "";
    if (lowOverallActivitiesMap.length == 0) {
      lowMapString = "n.a.";
    }
    for (var i = 0; i < lowOverallActivitiesMap.length; i++) {
      lowMapString +=
          "${i + 1}) ${lowOverallActivitiesMap.keys.toList()[i]} (${lowOverallActivitiesMap.values.toList()[i]} times)\n";
      // stop at top 3
      if (i == 2) {
        break;
      }
    }

    return [highMapString, lowMapString];
  }
}
