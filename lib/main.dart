import 'health_record.dart';
import 'list_health_record.dart';

void main() {
  ListHealthRecord list = ListHealthRecord();

  // CREATE
  list.addRecord(HealthRecord("h1", "An", 20, 60, 1.7));
  list.addRecord(HealthRecord("h2", "Binh", 22, 70, 1.75));

  // READ
  print("Danh sach ban dau:");
  list.getAllRecords();

  // UPDATE
  list.updateRecord("h1", "An Updated", 21, 62, 1.7);

  print("Sau khi cap nhat:");
  list.getAllRecords();

  // DELETE
  list.deleteRecord("h2");

  print("Sau khi xoa:");
  list.getAllRecords();
}
