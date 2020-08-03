import 'package:charts_flutter/flutter.dart' as charts;
import 'package:feel/common/Common.dart';
import 'package:feel/models/DataSetItem.dart';
import 'package:feel/models/DataSetModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// import 'package:feel/common/CustomCircleSymbolRenderer.dart';

class EvenLineChart extends StatefulWidget {
  @override
  _EvenLineChartState createState() => _EvenLineChartState();
}

class _EvenLineChartState extends State<EvenLineChart> {
  List<charts.Series<DataSetItem, int>> seriesList = [];
  final bool animate = true;
  int selectedIndex = 0;
  String selectedIndexLabel = "";

  @override
  Widget build(BuildContext context) {
    final _dataSets = Provider.of<DataSetModel>(context);
    final _fontFamily = DefaultTextStyle.of(context).style.fontFamily;
    final _dataSetItemProperties = Provider.of<DataSetItemProperties>(context);

    seriesList.clear();
    _dataSetItemProperties.getUnfilteredProperties().forEach((property) {
      seriesList.add(
        charts.Series<DataSetItem, int>(
            id: property.niceName,
            colorFn: (_, __) => property.color,
            domainFn: (DataSetItem dataSetItem, _) =>
                _dataSets.dataSets.indexOf(dataSetItem),
            measureFn: (DataSetItem dataSetItem, _) =>
                dataSetItem.toJson()[property.name],
            data: _dataSets.dataSetsList),
      );
    });

    var contentChart = new charts.LineChart(
      seriesList,
      animate: animate,
      selectionModels: [
        new charts.SelectionModelConfig(
            type: charts.SelectionModelType.info,
            changedListener: (charts.SelectionModel model) {
              DataSetItem selectedItem = model.selectedDatum.first.datum;
              setState(() {
                selectedIndex = model.selectedDatum.first.index;
                selectedIndexLabel =
                    DateFormat.yMd().add_Hm().format(selectedItem.time);
              });
            })
      ],
      // enabling LineRendererConfig will make points appear, but also make
      // setState() to reload the whole widget -> ugly
      // defaultRenderer: new charts.LineRendererConfig(includePoints: true),
      layoutConfig: new charts.LayoutConfig(
          leftMarginSpec: new charts.MarginSpec.fixedPixel(60),
          topMarginSpec: new charts.MarginSpec.fixedPixel(20),
          rightMarginSpec: new charts.MarginSpec.fixedPixel(60),
          bottomMarginSpec: new charts.MarginSpec.fixedPixel(20)),
      behaviors: [
        // getLegend(context),
        // new charts.LinePointHighlighter(
        //     symbolRenderer: CustomCircleSymbolRenderer()),
        new charts.RangeAnnotation([
          new charts.LineAnnotationSegment(
              selectedIndex, charts.RangeAnnotationAxisType.domain,
              labelStyleSpec: charts.TextStyleSpec(
                  color: charts.MaterialPalette.white.darker),
              labelDirection: charts.AnnotationLabelDirection.horizontal,
              middleLabel: selectedIndexLabel),
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
      domainAxis: charts.NumericAxisSpec(
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
