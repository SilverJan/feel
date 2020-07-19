import 'package:feel/common/Enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddDataSetWidget extends StatefulWidget {
  @override
  _AddDataSetWidgetState createState() => _AddDataSetWidgetState();
}

class _AddDataSetWidgetState extends State<AddDataSetWidget> {
  final _formKey = GlobalKey<FormState>();
  double _dizzinessValue = 0;
  double _headacheValue = 0;
  double _heartbeatValue = 0;

  bool isSelectedElevator = false;
  bool isSelectedWasher = false;
  bool isSelectedFireplace = false;

  @override
  Widget build(BuildContext context) {
    final chips = [
      FilterChip(
        label: Text("Bla"),
        selected: isSelectedElevator,
        onSelected: (value) {
          setState(() {
            isSelectedElevator = !isSelectedElevator;
          });
        },
      ),
      FilterChip(
        label: Text("Blu"),
        selected: isSelectedWasher,
        onSelected: (value) {
          setState(() {
            isSelectedWasher = !isSelectedWasher;
          });
        },
      ),
      FilterChip(
        label: Text("blo"),
        selected: isSelectedFireplace,
        onSelected: (value) {
          setState(() {
            isSelectedFireplace = !isSelectedFireplace;
          });
        },
      ),
    ];

    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Card(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListTile(
          tileColor: Colors.blueGrey,
          title: Text(
            "Submit a new data set",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          subtitle: Text(
              "Try to fill in the questions based on the past 30 minutes to 1 hour."),
        ),
      ),
      Card(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    Text(
                      "Which activities have you done in the past minutes?",
                    ),
                    // Wrap(children: [
                    //   for (final chip in chips)
                    //     Padding(
                    //       padding: const EdgeInsets.all(4),
                    //       child: chip,
                    //     )
                    // ]),
                    SizedBox(
                        width: 300,
                        height: 200,
                        child: GridView.builder(
                          itemCount: Activities.ACTIVITIES.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                color: Colors.black12,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(Activities
                                        .ACTIVITIES[index].keys.first),
                                    Icon(
                                      Activities.ACTIVITIES[index].values.first,
                                      size: 40,
                                    )
                                  ],
                                ));
                          },
                        )),
                    Divider(),
                    Text(
                      "Do you feel dizzy? (0 = not at all, 5 = very much)",
                    ),
                    Slider(
                        onChanged: (value) {
                          setState(() {
                            _dizzinessValue = value;
                          });
                        },
                        min: 0,
                        max: 5,
                        divisions: 5,
                        value: _dizzinessValue,
                        label: _dizzinessValue.toString()),
                    Divider(),
                    Text(
                      "Do you have headache? (0 = not at all, 5 = very much)",
                    ),
                    Slider(
                        onChanged: (value) {
                          setState(() {
                            _headacheValue = value;
                          });
                        },
                        min: 0,
                        max: 5,
                        divisions: 5,
                        value: _headacheValue,
                        label: _headacheValue.toString()),
                    Divider(),
                    Text(
                      "Do you have a fast heartbeat? (0 = not at all, 5 = very much)",
                    ),
                    Slider(
                        onChanged: (value) {
                          setState(() {
                            _heartbeatValue = value;
                          });
                        },
                        min: 0,
                        max: 5,
                        divisions: 5,
                        value: _heartbeatValue,
                        label: _heartbeatValue.toString())
                  ]),
            ),
          ))
    ]);
  }
}
