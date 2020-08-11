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
  double _coughingValue = 0;
  double _heartbeatValue = 0;
  double _breathingIssuesValue = 0;
  double _stressValue = 0;
  double _tirednessValue = 0;
  TextEditingController _freeTextInput = new TextEditingController();

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

  @override
  void initState() {
    resetSelectedActivities();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _freeTextInput.dispose();
    super.dispose();
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
      _coughingValue = 0;
      _heartbeatValue = 0;
      _breathingIssuesValue = 0;
      _stressValue = 0;
      _tirednessValue = 0;
      _freeTextInput.clear();
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
                  _coughingValue,
                  _dizzinessValue,
                  _coughingValue,
                  _breathingIssuesValue,
                  _stressValue,
                  _tirednessValue,
                  _freeTextInput.value.text,
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
                padding: EdgeInsets.only(top: 50),
                child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(children: [
                      Container(
                          margin: EdgeInsets.all(10),
                          color: Theme.of(context).secondaryHeaderColor,
                          child: ListTile(
                            title: Text(
                              "Submit a new data set",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            subtitle: Text(
                                "Try to fill in the questions based on the past 30-60 minutes."),
                          )),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                ),
                                Text(
                                  "Which activities have you done in the past minutes?",
                                ),
                                Wrap(children: [
                                  for (FilterChip chip in _buildChips())
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: chip)
                                ]),
                                FormElement(
                                  value: _overallValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _overallValue = value;
                                    });
                                  },
                                  text:
                                      "How good is your overall health situation?",
                                ),
                                FormElement(
                                  value: _dizzinessValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _dizzinessValue = value;
                                    });
                                  },
                                  text: "Do you feel dizzy?",
                                ),
                                FormElement(
                                    value: _coughingValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _coughingValue = value;
                                      });
                                    },
                                    text:
                                        "Do you have to cough / feel need to cough?"),
                                FormElement(
                                    value: _heartbeatValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _heartbeatValue = value;
                                      });
                                    },
                                    text: "Do you have a fast heartbeat?"),
                                FormElement(
                                    value: _breathingIssuesValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _breathingIssuesValue = value;
                                      });
                                    },
                                    text: "Do you have issues breathing?"),
                                FormElement(
                                    value: _stressValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _stressValue = value;
                                      });
                                    },
                                    text: "Do you feel stressed?"),
                                FormElement(
                                    value: _tirednessValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _tirednessValue = value;
                                      });
                                    },
                                    text: "Do you feel tired?"),
                                Divider(),
                                Text(
                                    "Enter an optional description of your current health state."),
                                TextFormField(
                                  controller: _freeTextInput,
                                  // decoration: InputDecoration(
                                  //     labelText: 'Enter a freetext'),
                                )
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

class FormElement extends StatelessWidget {
  const FormElement({
    Key key,
    @required this.value,
    @required this.onChanged,
    @required this.text,
    this.leadingWidget = const Icon(Icons.mood),
    this.trailingWidget = const Icon(Icons.mood_bad),
  }) : super(key: key);

  final double value;
  final Function onChanged;
  final String text;
  final Widget leadingWidget;
  final Widget trailingWidget;

  final double _sliderMin = 0;
  final double _sliderMax = 5;
  final int _sliderDivisions = 10;

  SliderThemeData getSliderThemeData(double value) {
    return SliderThemeData(
        activeTrackColor: (value < 1.66)
            ? Colors.green
            : (value < 3.33) ? Colors.orange : Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Divider(),
          Text(text),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            leadingWidget == null ? Container() : leadingWidget,
            Expanded(
                child: SliderTheme(
                    data: getSliderThemeData(value),
                    child: Slider(
                        // TODO: Try to call setState() in here
                        onChanged: onChanged,
                        min: _sliderMin,
                        max: _sliderMax,
                        divisions: _sliderDivisions,
                        value: value,
                        label: value.toString()))),
            trailingWidget == null ? Container() : trailingWidget,
          ]),
        ]);
  }
}
