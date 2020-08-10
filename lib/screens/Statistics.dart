import 'package:feel/models/DataSetItem.dart';
import 'package:feel/models/DataSetModel.dart';
import 'package:feel/screens/charts/ActivityCorrelationChart.dart';
import 'package:feel/screens/charts/AverageChart.dart';
import 'package:feel/screens/charts/EvenLineChart.dart';
import 'package:feel/screens/charts/HistoricalLineChart.dart';
import 'package:feel/screens/charts/TodayLineChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class Statistics extends StatefulWidget {
  @override
  _RawStatisticsState createState() => _RawStatisticsState();
}

class _RawStatisticsState extends State<Statistics> {
  ScrollController scrollController;
  bool dialVisible = true;
  DataSetItemProperties dataSetItemProperties;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  SpeedDial buildSpeedDial() {
    List<SpeedDialChild> speedDialChildren = [];

    dataSetItemProperties.getAllProperties().forEach((element) {
      Color elementColor =
          Color.fromRGBO(element.color.r, element.color.g, element.color.b, 1);
      Color elementColorDisabled = Colors.grey.withOpacity(0.38);

      speedDialChildren.add(SpeedDialChild(
        // child: Icon(Icons.fil, color: Colors.white),
        onTap: () {
          dataSetItemProperties.addFilteredProperty(element);
          // reload all widgets
          setState(() {});
        },
        label: element.niceName,
        labelStyle: dataSetItemProperties.isPropertyFiltered(element)
            ? TextStyle(fontWeight: FontWeight.w400, color: Colors.black)
            // decoration: TextDecoration.lineThrough)
            : TextStyle(color: Colors.white),
        backgroundColor: dataSetItemProperties.isPropertyFiltered(element)
            ? elementColorDisabled
            : elementColor,
        labelBackgroundColor: dataSetItemProperties.isPropertyFiltered(element)
            ? elementColorDisabled
            : elementColor,
        // labelBackgroundColor: Colors.amber[800],
      ));
    });

    return SpeedDial(
        // animatedIcon: AnimatedIcons.event_add,
        // animatedIconTheme: IconThemeData(size: 22.0),
        child: Icon(Icons.filter_list),
        backgroundColor: Colors.amber[800],
        visible: dialVisible,
        overlayOpacity: 0,
        closeManually: true,
        // curve: Curves.bounceIn,
        children: speedDialChildren);
  }

  @override
  Widget build(BuildContext context) {
    dataSetItemProperties = Provider.of<DataSetItemProperties>(context);
    final _dataSets = Provider.of<DataSetModel>(context);
    double width = MediaQuery.of(context).size.width;

    List<Widget> statisticWidgets = [
      StatisticsCard(
        title: "Average Health Values",
        chart: AverageChart(),
        // rightInfo: "30d",
        subTitle:
            "Showing the average rating for the different properties that were analyzed",
      ),
      StatisticsCard(
        title: "Impact of Activities on Health",
        chart: ActivityCorrelationChart(),
        subTitle:
            "Here you can see which activity had which good/bad impact on your health",
        height: 400,
      ),
      StatisticsCard(
        title: "Historical Data (even)",
        chart: EvenLineChart(),
        subTitle: "This chart shows the historical data of all values",
      ),
      StatisticsCard(
        title: "Historical Data (time-based)",
        chart: HistoricalLineChart(),
        subTitle: "This chart shows the historical data of all values",
      ),
      StatisticsCard(
        title: "Today's Data",
        chart: TodayLineChart(),
        subTitle: "This chart shows today's data",
      )
    ];

    return Scaffold(
        floatingActionButton: buildSpeedDial(),
        body: _dataSets.dataSets.length > 4
            ? Column(children: [
                Expanded(
                    child: width > 700
                        ? GridView.count(
                            crossAxisCount: 2,
                            primary: false,
                            padding: const EdgeInsets.all(0),
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                            children: statisticWidgets)
                        : ListView(
                            children: statisticWidgets,
                          ))
              ])
            : Center(
                child: Text(
                "Not enough data available yet.\nCreate at least 5 data sets to show statistics.",
                textAlign: TextAlign.center,
              )));
  }
}

class StatisticsCard extends StatelessWidget {
  const StatisticsCard(
      {Key key,
      @required this.chart,
      @required this.title,
      this.subTitle,
      this.rightInfo = "",
      this.height = 400})
      : super(key: key);

  final Widget chart;
  final String title;
  final String subTitle; //TODO: Make subtitle child dynamic if empty or not
  final String rightInfo;
  final double height;

  static const EdgeInsets marginLinux = EdgeInsets.all(10);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: Card(
            // color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(children: [
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            this.title,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            this.rightInfo,
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                      Text(
                        this.subTitle,
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  )),
              Flexible(
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      child: this.chart))
            ])));
  }
}
