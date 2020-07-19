import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// enum Symptoms { headache, cough, fever, heartbeat }

// enum ActivitiesEnum { relax, gym, sleep, code, watchtv }

class Activities {
  // static const Map<String, IconData> RELAX = {
  //   "Relaxing": Icons.airline_seat_recline_extra
  // };
  // static const Map<String, IconData> GYM = {"Gym": Icons.directions_run};
  static const List<Map<String, IconData>> ACTIVITIES = [
    {"Relax": Icons.airline_seat_recline_extra},
    {"Sleep": Icons.directions_run},
    {"Code": Icons.keyboard},
    {"Gym": Icons.fitness_center},
    {"Walk": Icons.directions_walk},
    {"Run": Icons.directions_run},
    {"Gym": Icons.directions_run},
  ];
}
