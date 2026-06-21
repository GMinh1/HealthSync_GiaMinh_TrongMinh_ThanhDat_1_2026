# HealthSync App

## Giới thiệu

HealthSync là ứng dụng theo dõi sức khỏe được phát triển bằng Flutter. Ứng dụng giúp người dùng quản lý cân nặng, số bước chân và lượng calo tiêu thụ hàng ngày.

## Chức năng

* Quản lý dữ liệu sức khỏe
* Tính BMI
* Theo dõi lịch sử
* CRUD dữ liệu

## Công nghệ sử dụng

* Flutter
* Dart

## Thành viên

* Trần Trọng Minh (23010563)
* Phùng Gia Minh (23010869)
* Đỗ Thành Đạt (23011627)

Yêu cầu bài kiểm tra giữa kì:
- Home Screen (Trần Trọng Minh)
- Content Screen (Đỗ Thành Đạt)
- About Screen (Phùng Gia Minh):
  <img width="1919" height="904" alt="image" src="https://github.com/user-attachments/assets/13eb04e7-cff2-44a0-91b5-7269a09765d1" />

## giải thích về weight_bmi_page.dart
* Sơ đồ
<img width="520" height="642" alt="image" src="https://github.com/user-attachments/assets/72256e04-19cd-409d-b51d-f21b2c29981b" />

+ _fromFirestore(): xử lý dữ liệu từ docs (bao gồm height, weight, timestamp) và trả lại 1 object BmiRecord
 thông qua: final records = docs.map((doc) => _fromFirestore(doc)).toList();
sẽ đưa dữ liệu đã được sắp xếp vào records = [BmiRecord, BmiRecord,..]
+ r = record[i]: r là biến tạm đại diện cho 1 bản ghi BMI tại i trong danh sách records với mục đích là hiển thị lịch sử nhập
+ latest = records.first: dùng để hiển thị dữ liệu nhập mới nhất


