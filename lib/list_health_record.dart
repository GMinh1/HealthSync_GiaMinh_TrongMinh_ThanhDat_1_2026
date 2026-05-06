import 'health_record.dart';

class ListHealthRecord {
  List<HealthRecord> records = [];

  // CREATE
  void addRecord(HealthRecord record) {
    records.add(record);
  }

  // READ
  void getAllRecords() {
    for (var r in records) {
      r.displayInfo();
    }
  }

  // UPDATE
  void updateRecord(String id, String name, int age, double weight, double height) {
    for (var r in records) {
      if (r.id == id) {
        r.updateInfo(name, age, weight, height);
      }
    }
  }

  // DELETE
  void deleteRecord(String id) {
    records.removeWhere((r) => r.id == id);
  }
}