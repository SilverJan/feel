import 'package:feel/common/FileAccess.dart';
import 'package:flutter/widgets.dart';

import 'DataSetItem.dart';

class DataSetModel extends ChangeNotifier {
  List<DataSetItem> dataSets = [];
  FileAccess storage = new FileAccess();

  DataSetModel() {
    storage.readDataSets().then((List<DataSetItem> dataSetItems) {
      dataSets = dataSetItems;
      sortDataSets();
      notifyListeners();
    });
  }

  void persistDataSetsInFile() {
    storage.writeDataSets(dataSets);
    notifyListeners();
  }

  List<DataSetItem> get dataSetsList => dataSets;

  int get length => dataSets.length;

  /// Get item by [id].
  DataSetItem getById(String id) =>
      dataSets.firstWhere((element) => element.id == id, orElse: () => null);

  /// Add dataSetItem to list of datasets, sort and persist the list
  void addDataSet(DataSetItem dataSetItem) {
    dataSets.add(dataSetItem);
    sortDataSets();
    persistDataSetsInFile();
  }

  /// Remove dataSetItem from list of datasets, sort and persist the list
  void removeDataSet(String id) {
    dataSets.remove(getById(id));
    sortDataSets();
    persistDataSetsInFile();
  }

  /// Sort countdowns based on DateTime
  void sortDataSets() {
    dataSets.sort((a, b) => a.compareTo(b));
  }
}
