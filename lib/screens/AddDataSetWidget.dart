import 'package:feel/models/DataSetItem.dart';
import 'package:feel/models/DataSetModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AddDataSetWidget extends StatefulWidget {
  @override
  _AddDataSetWidgetState createState() => _AddDataSetWidgetState();
}

class _AddDataSetWidgetState extends State<AddDataSetWidget> {
  final _formKey = GlobalKey<FormState>();
  double _overallValue = 0;
  double _dizzinessValue = 0;
  double _headacheValue = 0;
  double _heartbeatValue = 0;
  double _breathingIssuesValue = 0;
  double _stressValue = 0;

  final List<String> _activities = [
    'Gym',
    'Walk',
    'Run',
    'Relax',
    'Sleep',
    'Use phone',
    'Code',
    'Work',
    'Eat/Drink',
    'Socialize',
    'Shopping',
    'Listen to music'
  ];
  List<bool> _activitySelected;

  double _sliderMin = 0;
  double _sliderMax = 5;
  int _sliderDivisions = 10;

  @override
  void initState() {
    resetSelectedActivities();
    super.initState();
  }

  /// Generate list dynamically depending on amount of activities available
  void resetSelectedActivities() {
    _activitySelected =
        List<bool>.generate(_activities.length, (index) => false);
  }

  void resetForm() {
    setState(() {
      _overallValue = 0;
      _dizzinessValue = 0;
      _headacheValue = 0;
      _heartbeatValue = 0;
      _breathingIssuesValue = 0;
      _stressValue = 0;
      resetSelectedActivities();
    });
  }

  List<Widget> _buildChips() {
    List<Widget> chips = new List();
    for (int i = 0; i < _activities.length; i++) {
      chips.add(FilterChip(
        selected: _activitySelected[i],
        // avatar: Icon(Icons.border_all),
        label: Text(_activities[i], style: TextStyle(color: Colors.white)),
        onSelected: (bool selected) {
          setState(() {
            _activitySelected[i] = selected;
          });
        },
      ));
    }
    return chips;
  }

  List<String> _getSelectedActivities() {
    List<String> selectedActivities = [];
    _activities.asMap().forEach((i, activity) {
      if (_activitySelected[i]) {
        selectedActivities.add(activity);
      }
    });
    return selectedActivities;
  }

  SliderThemeData getSliderThemeData(double value) {
    return SliderThemeData(
        activeTrackColor: (value < 1.66)
            ? Colors.green
            : (value < 3.33) ? Colors.orange : Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    final _dataSets = Provider.of<DataSetModel>(context);
    final _theme = Theme.of(context);

    return Scaffold(
        floatingActionButton: new FloatingActionButton(
            child: Icon(Icons.add),
            // tooltip: "Submit",
            backgroundColor: _theme.buttonColor,
            onPressed: () {
              _dataSets.addDataSet(new DataSetItem(
                  DateTime.now(),
                  _overallValue,
                  _headacheValue,
                  _dizzinessValue,
                  _headacheValue,
                  _breathingIssuesValue,
                  _stressValue,
                  _getSelectedActivities()));
              resetForm();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Data set successfully added!"),
                duration: Duration(
                  milliseconds: 1000,
                ),
                behavior: SnackBarBehavior.floating,
              ));
            }),
        body: Center(
            child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 30),
                child:
                    // Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    //     Widget>[
                    // Card(
                    //   margin: EdgeInsets.symmetric(horizontal: 15),
                    //   child: ListTile(
                    //     tileColor: Theme.of(context).secondaryHeaderColor,
                    //     title: Text(
                    //       "Submit a new data set",
                    //       style: TextStyle(color: Colors.white, fontSize: 20),
                    //     ),
                    //     subtitle: Text(
                    //         "Try to fill in the questions based on the past 30-60 minutes."),
                    //   ),
                    // ),
                    Card(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(children: [
                          ListTile(
                            tileColor: Theme.of(context).secondaryHeaderColor,
                            title: Text(
                              "Submit a new data set",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            subtitle: Text(
                                "Try to fill in the questions based on the past 30-60 minutes."),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                    ),
                                    Text(
                                      "Which activities have you done in the past minutes?",
                                    ),
                                    Wrap(children: [
                                      for (FilterChip chip in _buildChips())
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: chip)
                                    ]),
                                    // ListTile(
                                    //   tileColor: Theme.of(context).primaryColor,
                                    //   title: Text(
                                    //     "Health check",
                                    //     style: TextStyle(
                                    //         color: Colors.white, fontSize: 17),
                                    //   ),
                                    //   subtitle: Text(
                                    //       "Select a value for the individual question (0 = Not applicable; 5 = Very much)"),
                                    // ),
                                    // Padding(
                                    //   padding: EdgeInsets.symmetric(vertical: 10),
                                    // ),
                                    // Divider(),
                                    // Text(
                                    //   "Select a value for the individual question.\n\n0 = Not applicable; 5 = Very much",
                                    //   textAlign: TextAlign.center,
                                    // ),
                                    Divider(),
                                    Text(
                                      "How good is your overall health situation?",
                                    ),
                                    SliderTheme(
                                        data: getSliderThemeData(_overallValue),
                                        child: Slider(
                                            onChanged: (value) {
                                              setState(() {
                                                _overallValue = value;
                                              });
                                            },
                                            min: _sliderMin,
                                            max: _sliderMax,
                                            divisions: _sliderDivisions,
                                            value: _overallValue,
                                            label: _overallValue.toString())),
                                    Divider(),
                                    Text(
                                      "Do you feel dizzy?",
                                    ),
                                    SliderTheme(
                                        data:
                                            getSliderThemeData(_dizzinessValue),
                                        child: Slider(
                                            onChanged: (value) {
                                              setState(() {
                                                _dizzinessValue = value;
                                              });
                                            },
                                            min: _sliderMin,
                                            max: _sliderMax,
                                            divisions: _sliderDivisions,
                                            value: _dizzinessValue,
                                            label: _dizzinessValue.toString())),
                                    Divider(),
                                    Text(
                                      "Do you have to cough / feel need to cough?",
                                    ),
                                    SliderTheme(
                                        data:
                                            getSliderThemeData(_headacheValue),
                                        child: Slider(
                                            onChanged: (value) {
                                              setState(() {
                                                _headacheValue = value;
                                              });
                                            },
                                            min: _sliderMin,
                                            max: _sliderMax,
                                            divisions: _sliderDivisions,
                                            value: _headacheValue,
                                            label: _headacheValue.toString())),
                                    Divider(),
                                    Text(
                                      "Do you have a fast heartbeat?",
                                    ),
                                    SliderTheme(
                                        data:
                                            getSliderThemeData(_heartbeatValue),
                                        child: Slider(
                                            onChanged: (value) {
                                              setState(() {
                                                _heartbeatValue = value;
                                              });
                                            },
                                            min: _sliderMin,
                                            max: _sliderMax,
                                            divisions: _sliderDivisions,
                                            value: _heartbeatValue,
                                            label: _heartbeatValue.toString())),
                                    Divider(),
                                    Text(
                                      "Do you have issues breathing?",
                                    ),
                                    SliderTheme(
                                        data: getSliderThemeData(
                                            _breathingIssuesValue),
                                        child: Slider(
                                            onChanged: (value) {
                                              setState(() {
                                                _breathingIssuesValue = value;
                                              });
                                            },
                                            min: _sliderMin,
                                            max: _sliderMax,
                                            divisions: _sliderDivisions,
                                            value: _breathingIssuesValue,
                                            label: _breathingIssuesValue
                                                .toString())),
                                    Divider(),
                                    Text(
                                      "Do you feel stressed?",
                                    ),
                                    SliderTheme(
                                        data: getSliderThemeData(_stressValue),
                                        child: Slider(
                                            onChanged: (value) {
                                              setState(() {
                                                _stressValue = value;
                                              });
                                            },
                                            min: _sliderMin,
                                            max: _sliderMax,
                                            divisions: _sliderDivisions,
                                            value: _stressValue,
                                            label: _stressValue.toString())),
                                    // Divider(),
                                    // RaisedButton(
                                    //   // color: _theme.buttonTheme.colorScheme.primary,
                                    //   child: Text("Submit"),
                                    //   onPressed: () {
                                    //     _dataSets.addDataSet(new DataSetItem(
                                    //         DateTime.now(),
                                    //         _overallValue,
                                    //         _headacheValue,
                                    //         _dizzinessValue,
                                    //         _headacheValue,
                                    //         _breathingIssuesValue,
                                    //         _getSelectedActivities()));
                                    //     resetForm();
                                    //     Scaffold.of(context).showSnackBar(SnackBar(
                                    //       content: Text("Data set successfully added!"),
                                    //       duration: Duration(milliseconds: 1000),
                                    //     ));
                                    //   },
                                    // )
                                  ]),
                            ),
                          )
                        ])))));
  }
}
