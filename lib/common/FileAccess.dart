import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:feel/models/DataSetItem.dart';
import 'package:path_provider/path_provider.dart';

class FileAccess {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/.datasets.json');
  }

  Future<List<DataSetItem>> readDataSets() async {
    try {
      final file = await _localFile;

      // Read the file
      String content = await file.readAsString();
      List dataSetItemMapList = jsonDecode(content);
      List<DataSetItem> dataSetItemList = [];
      for (Map countdownItemMap in dataSetItemMapList) {
        dataSetItemList.add(DataSetItem.fromJson(countdownItemMap));
      }
      return dataSetItemList;
    } catch (e) {
      // If encountering an error, return empty array
      print("An error occured while reading data sets from json file! " +
          e.toString());
      return [];
    }
  }

  Future<File> writeDataSets(List<DataSetItem> dataSetItems) async {
    final file = await _localFile;

    // Create JSON out of all dataSetItems
    var completeJson = "[";

    for (var i = 0; i < dataSetItems.length; i++) {
      String json = jsonEncode(dataSetItems[i]);
      completeJson += "${json},";

      if (i == dataSetItems.length - 1) {
        completeJson = completeJson.substring(0, completeJson.length - 1);
      }
    }

    completeJson += "]";

    // Write the file
    return file.writeAsString(completeJson);
  }
}
