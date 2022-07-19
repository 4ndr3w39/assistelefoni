import 'package:firebase_database/firebase_database.dart';

updateData(String status, var key, DatabaseReference ref) {
  Map<String, String> data = {"status": status};
  ref.child(key).update(data);
}
