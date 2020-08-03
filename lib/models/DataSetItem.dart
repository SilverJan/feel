import 'package:charts_flutter/flutter.dart';
import 'package:uuid/uuid.dart';

class DataSetItem extends Comparable {
  final String id;
  DateTime time;
  double overall;
  // double happiness;
  double headache;
  double dizziness;
  double heartbeat;
  double breathingIssues;
  List<String> activities;

  DataSetItem(this.time, this.overall, this.headache, this.dizziness,
      this.heartbeat, this.breathingIssues, this.activities)
      : id = Uuid().v1();

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is DataSetItem && other.id == id;

  @override
  int compareTo(other) {
    return time.compareTo(other.time);
  }

  DataSetItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        time = DateTime.parse(json['time']),
        overall = double.parse(json['overall'].toString()),
        headache = double.parse(json['headache'].toString()),
        dizziness = double.parse(json['dizziness'].toString()),
        heartbeat = double.parse(json['heartbeat'].toString()),
        breathingIssues = double.parse(json['breathingIssues'].toString()) {
    activities = List<String>.from(json['activities']);
    // activities = List.castFrom<dynamic, String>(json['activities']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'time': time.toIso8601String(),
        'overall': overall,
        'headache': headache,
        'dizziness': dizziness,
        'heartbeat': heartbeat,
        'breathingIssues': breathingIssues,
        'activities': activities
      };
}

class DataSetItemProperties {
  List<DataSetItemProperty> allProperties = [];
  List<DataSetItemProperty> filteredProperties = [];

  DataSetItemProperties() {
    allProperties = [
      DataSetItemProperty(
          "overall", "Overall", MaterialPalette.blue.shadeDefault),
      DataSetItemProperty(
          "headache", "Headache", MaterialPalette.red.shadeDefault),
      DataSetItemProperty(
          "dizziness", "Dizziness", MaterialPalette.green.shadeDefault),
      DataSetItemProperty(
          "heartbeat", "Fast heartbeat", MaterialPalette.purple.shadeDefault),
      DataSetItemProperty("breathingIssues", "Breathing issues",
          MaterialPalette.yellow.shadeDefault.darker.darker),
    ];
  }

  /// returns a static list of the available properties
  List<DataSetItemProperty> getAllProperties() {
    return allProperties;
  }

  /// returns a static list of the selected properties
  List<DataSetItemProperty> getUnfilteredProperties() {
    return allProperties
        .where((element) => !filteredProperties.contains(element))
        .toList();
  }

  bool isPropertyFiltered(DataSetItemProperty dataSetItemProperty) {
    return filteredProperties.contains(dataSetItemProperty);
  }

  void addFilteredProperty(DataSetItemProperty filteredProperty) {
    if (!filteredProperties.contains(filteredProperty)) {
      filteredProperties.add(filteredProperty);
    } else {
      print("already filtered, will remove");
      removeFilteredProperty(filteredProperty);
    }
  }

  void removeFilteredProperty(DataSetItemProperty filteredProperty) {
    filteredProperties.remove(filteredProperty);
  }
}

class DataSetItemProperty implements Comparable {
  String name;
  String niceName;
  Color color;

  DataSetItemProperty(String name, String niceName, Color color) {
    this.name = name;
    this.niceName = niceName;
    this.color = color;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) =>
      other is DataSetItemProperty && other.name == name;

  @override
  int compareTo(other) {
    return name.compareTo(other.name);
  }
}
