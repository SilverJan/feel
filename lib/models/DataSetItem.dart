import 'package:feel/common/Enums.dart';
import 'package:uuid/uuid.dart';

class DataSetItem extends Comparable {
  final String id;
  DateTime time;
  // double overall;
  // double happiness;
  // double health;
  double headache;
  double dizziness;
  double heartbeat;
  List<Activities> activities;

  DataSetItem(
      this.time, this.headache, this.dizziness, this.heartbeat, this.activities)
      : id = Uuid().v1();

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is DataSetItem && other.id == id;

  @override
  int compareTo(other) {
    return time.compareTo(other.time);
  }

  DataSetItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        time = DateTime.parse(json['time']),
        headache = json['headache'],
        dizziness = json['diziness'],
        heartbeat = json['heartbeat'],
        activities = json['activities'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'time': time.toIso8601String(),
        'headache': headache,
        'dizziness': dizziness,
        'heartbeat': heartbeat,
        'activities': activities // FIXME
      };
}
