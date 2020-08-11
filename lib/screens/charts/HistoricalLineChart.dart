import 'package:charts_flutter/flutter.dart' as charts;
import 'package:feel/common/Common.dart';
import 'package:feel/models/DataSetItem.dart';
import 'package:feel/models/DataSetModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HistoricalLineChart extends StatefulWidget {
  @override
  _HistoricalLineChartState createState() => _HistoricalLineChartState();
}

class _HistoricalLineChartState extends State<HistoricalLineChart> {
  List<charts.Series<DataSetItem, DateTime>> seriesList = [];
  final bool animate = true;

  @override
  Widget build(BuildContext context) {
    final _dataSets = Provider.of<DataSetModel>(context);
    final _fontFamily = DefaultTextStyle.of(context).style.fontFamily;
    final _dataSetItemProperties = Provider.of<DataSetItemProperties>(context);

    seriesList.clear();
    _dataSetItemProperties.getUnfilteredProperties().forEach((property) {
      seriesList.add(
        charts.Series<DataSetItem, DateTime>(
            id: property.niceName,
            colorFn: (_, __) => property.color,
            domainFn: (DataSetItem dataSetItem, _) => dataSetItem.time,
            measureFn: (DataSetItem dataSetItem, _) =>
                dataSetItem.toJson()[property.name],
            data: _dataSets.dataSetsList),
      );
    });

    // seriesList = [
    //   charts.Series<DataSetItem, DateTime>(
    //       id: "Overall",
    //       colorFn: (DataSetItem dataSetItem, __) =>
    //           charts.MaterialPalette.blue.shadeDefault,
    //       domainFn: (DataSetItem dataSetItem, _) => dataSetItem.time,
    //       measureFn: (DataSetItem dataSetItem, _) => dataSetItem.overall,
    //       data: _dataSets.dataSetsList),
    //   charts.Series<DataSetItem, DateTime>(
    //       id: 'Dizziness',
    //       colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
    //       domainFn: (DataSetItem dataSetItem, _) => dataSetItem.time,
    //       measureFn: (DataSetItem dataSetItem, _) => dataSetItem.dizziness,
    //       data: _dataSets.dataSetsList),
    //   charts.Series<DataSetItem, DateTime>(
    //       id: 'Headache',
    //       colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
    //       domainFn: (DataSetItem dataSetItem, _) => dataSetItem.time,
    //       measureFn: (DataSetItem dataSetItem, _) => dataSetItem.headache,
    //       data: _dataSets.dataSetsList),
    //   charts.Series<DataSetItem, DateTime>(
    //       id: 'Fast Heartbeat',
    //       colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
    //       domainFn: (DataSetItem dataSetItem, _) => dataSetItem.time,
    //       measureFn: (DataSetItem dataSetItem, _) => dataSetItem.heartbeat,
    //       data: _dataSets.dataSetsList),
    //   charts.Series<DataSetItem, DateTime>(
    //       id: 'Breathing Issues',
    //       colorFn: (_, __) => charts.MaterialPalette.black,
    //       domainFn: (DataSetItem dataSetItem, _) => dataSetItem.time,
    //       measureFn: (DataSetItem dataSetItem, _) =>
    //           dataSetItem.breathingIssues,
    //       data: _dataSets.dataSetsList)
    // ];

    var contentChart = new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.LineRendererConfig(includePoints: true),
      // Allow enough space in the left and right chart margins for the
      // annotations.
      layoutConfig: new charts.LayoutConfig(
          leftMarginSpec: new charts.MarginSpec.fixedPixel(60),
          topMarginSpec: new charts.MarginSpec.fixedPixel(20),
          rightMarginSpec: new charts.MarginSpec.fixedPixel(20),
          bottomMarginSpec: new charts.MarginSpec.fixedPixel(20)),
      behaviors: [
        // getLegend(context),
        new charts.RangeAnnotation([
          new charts.RangeAnnotationSegment(
              0, 1.66, charts.RangeAnnotationAxisType.measure,
              middleLabel: 'Good',
              labelStyleSpec:
                  charts.TextStyleSpec(color: charts.MaterialPalette.white),
              color: charts.MaterialPalette.transparent,
              // color: charts.MaterialPalette.green.makeShades(10)[0],
              labelAnchor: charts.AnnotationLabelAnchor.start),
          new charts.RangeAnnotationSegment(
              1.66, 3.33, charts.RangeAnnotationAxisType.measure,
              middleLabel: 'Medium',
              labelStyleSpec:
                  charts.TextStyleSpec(color: charts.MaterialPalette.white),
              color: charts.MaterialPalette.transparent,
              // color: charts.MaterialPalette.yellow.makeShades(10)[0],
              labelAnchor: charts.AnnotationLabelAnchor.start),
          new charts.RangeAnnotationSegment(
              3.33, 5, charts.RangeAnnotationAxisType.measure,
              middleLabel: 'Bad',
              labelStyleSpec:
                  charts.TextStyleSpec(color: charts.MaterialPalette.white),
              color: charts.MaterialPalette.transparent,
              // color: charts.MaterialPalette.red.makeShades(10)[0],
              labelAnchor: charts.AnnotationLabelAnchor.start),
        ], defaultLabelPosition: charts.AnnotationLabelPosition.margin),
      ],

      /// Assign a custom style for the domain axis.
      domainAxis: charts.DateTimeAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
              labelStyle: charts.TextStyleSpec(
                  fontSize: 10, color: charts.MaterialPalette.white),
              lineStyle: charts.LineStyleSpec(
                  thickness: 0,
                  color: charts.MaterialPalette.gray.shadeDefault))),

      /// Assign a custom style for the measure axis.
      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.GridlineRendererSpec(
              // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 12,
                  fontFamily: _fontFamily,
                  color: charts.MaterialPalette.white),
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.white))),
    );
    return contentChart;
  }
}
