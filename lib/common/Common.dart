import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

SeriesLegend getLegend(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

  OutsideJustification outsideJustification =
      OutsideJustification.startDrawArea;

  /// workaround for not-available auto-wrapping of legend
  int maxColumns;
  if (width < 675 && width >= 500) {
    maxColumns = 3;
  } else if (width < 500 && width >= 300) {
    maxColumns = 3;
    outsideJustification = OutsideJustification.start;
  } else if (width < 300) {
    maxColumns = 1;
    outsideJustification = OutsideJustification.start;
  }

  return SeriesLegend(
      desiredMaxColumns: maxColumns,
      outsideJustification: outsideJustification);
}

String formatDateTime(DateTime dateTime) {
  return DateFormat.yMd().add_Hm().add_EEEE().format(dateTime);
}
