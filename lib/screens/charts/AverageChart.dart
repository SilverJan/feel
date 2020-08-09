import 'package:charts_flutter/flutter.dart' as charts;
import 'package:feel/models/DataSetItem.dart';
import 'package:feel/models/DataSetModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AverageChart extends StatefulWidget {
  @override
  _AverageChartState createState() => _AverageChartState();
}

class _AverageChartState extends State<AverageChart> {
  List<charts.Series<AverageValue, String>> seriesList = [];

  final bool animate = true;

  @override
  Widget build(BuildContext context) {
    final _dataSets = Provider.of<DataSetModel>(context);
    final _fontFamily = DefaultTextStyle.of(context).style.fontFamily;

    AverageValueList averages = AverageValueList(_dataSets.dataSets, context);

    seriesList = [
      charts.Series<AverageValue, String>(
          id: 'Average',
          colorFn: (AverageValue averageValue, __) => averageValue.color,
          domainFn: (AverageValue averageValue, _) =>
              averageValue.property.niceName,
          measureFn: (AverageValue averageValue, _) => averageValue.value,
          data: averages.averageValues),
    ];

    final staticTicks = <charts.TickSpec<double>>[
      new charts.TickSpec(0),
      new charts.TickSpec(1, label: "Good"),
      new charts.TickSpec(2.5, label: "Medium"),
      new charts.TickSpec(4, label: "Bad"),
      new charts.TickSpec(5),
    ];

    var contentChart = new charts.BarChart(
      seriesList,
      animate: animate,

      /// Assign a custom style for the domain axis.
      ///
      /// This is an OrdinalAxisSpec to match up with BarChart's default
      /// ordinal domain axis (use NumericAxisSpec or DateTimeAxisSpec for
      /// other charts).
      domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec(
              // Tick and Label styling here.
              labelRotation: 40,
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 12,
                  fontFamily: _fontFamily,
                  color: charts.MaterialPalette.white),
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.white))),

      /// Assign a custom style for the measure axis.
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec:
              new charts.StaticNumericTickProviderSpec(staticTicks),
          renderSpec: new charts.GridlineRendererSpec(
              // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 12,
                  fontFamily: _fontFamily,
                  color: charts.MaterialPalette.white),
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.white.lighter))),
      // behaviors: [
      //   new charts.ChartTitle('Average values',
      //       titleStyleSpec: charts.TextStyleSpec(
      //           color: white, fontFamily: _fontFamily, fontSize: 15),
      //       behaviorPosition: charts.BehaviorPosition.bottom,
      //       titleOutsideJustification:
      //           charts.OutsideJustification.middleDrawArea),
      // ],
    );
    return contentChart;
  }
}

/// Because charts_flutter requires always a list of items to show, we're creating
/// a wrapper class which contains the AverageValue objects
///
/// An AverageValue object contains "property" and "attribute"
/// Example: "property": "overall" ; "value" : 3.5
class AverageValueList {
  List<AverageValue> averageValues = [];
  BuildContext context;

  /// Dynamically create list of AverageValues based on list of data sets
  AverageValueList(List<DataSetItem> dataSets, context) {
    final _dataSetItemProperties = Provider.of<DataSetItemProperties>(context);
    _dataSetItemProperties.getUnfilteredProperties().forEach((property) {
      averageValues.add(AverageValue(dataSets, property, property.color));
    });
  }
}

class AverageValue {
  double value;
  DataSetItemProperty property;
  charts.Color color;

  AverageValue(List<DataSetItem> dataSets, DataSetItemProperty property,
      charts.Color color) {
    this.property = property;
    this.color = color;
    double value = 0;
    dataSets.forEach((DataSetItem dataSet) {
      try {
        value += dataSet.toJson()[property.name];
      } catch (e) {
        value += 0;
      }
    });
    this.value = value / dataSets.length;
  }
}
