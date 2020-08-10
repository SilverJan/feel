import 'package:charts_flutter/flutter.dart';
import 'package:uuid/uuid.dart';

class DataSetItem extends Comparable {
  final String id;
  DateTime time;
  double overall;
  double coughing;
  double dizziness;
  double heartbeat;
  double breathingIssues;
  double stress;
  double tiredness;
  String freeText;
  List<String> activities;

  DataSetItem(
      this.time,
      this.overall,
      this.coughing,
      this.dizziness,
      this.heartbeat,
      this.breathingIssues,
      this.stress,
      this.tiredness,
      this.freeText,
      this.activities)
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
        time = DateTime.tryParse(json['time']),
        overall = double.tryParse(json['overall'].toString()),
        coughing = double.tryParse(json['coughing'].toString()),
        dizziness = double.tryParse(json['dizziness'].toString()),
        heartbeat = double.tryParse(json['heartbeat'].toString()),
        breathingIssues = double.tryParse(json['breathingIssues'].toString()),
        stress = double.tryParse(json['stress'].toString()),
        tiredness = double.tryParse(json['tiredness'].toString()),
        freeText = json['freeText'].toString() {
    activities = List<String>.from(json['activities']);
    // activities = List.castFrom<dynamic, String>(json['activities']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'time': time.toIso8601String(),
        'overall': overall,
        'coughing': coughing,
        'dizziness': dizziness,
        'heartbeat': heartbeat,
        'breathingIssues': breathingIssues,
        'stress': stress,
        'tiredness': tiredness,
        'freeText': freeText,
        'activities': activities
      };

  @override
  String toString() {
    return """Overall: $overall 
Coughing: $coughing | Dizziness: $dizziness | Heartbeat: $heartbeat | Breathing issues: $breathingIssues | Stress: $stress | Tiredness: $tiredness
Optional Text: $freeText
Activities: $activities""";
  }
}

class DataSetItemProperties {
  List<DataSetItemProperty> allProperties = [];
  List<DataSetItemProperty> filteredProperties = [];

  DataSetItemProperties() {
    allProperties = [
      DataSetItemProperty(
          "overall", "Overall health", MaterialPalette.blue.shadeDefault),
      DataSetItemProperty(
          "coughing", "Coughing", MaterialPalette.red.shadeDefault),
      DataSetItemProperty(
          "dizziness", "Dizziness", MaterialPalette.green.shadeDefault),
      DataSetItemProperty(
          "heartbeat", "Fast heartbeat", MaterialPalette.purple.shadeDefault),
      DataSetItemProperty("breathingIssues", "Breathing issues",
          MaterialPalette.yellow.shadeDefault.darker.darker),
      DataSetItemProperty(
          "stress", "Stress level", MaterialPalette.pink.shadeDefault),
      DataSetItemProperty(
          "tiredness", "Tiredness level", MaterialPalette.indigo.shadeDefault),
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
