import 'package:dotslash_hackathon/models/VaccineStatus.dart';

class Vaccine {
  String name;
  String comments;
  List<String> reminders;

  Vaccine({
    this.comments,
    this.name,
    this.reminders,
  });
}
