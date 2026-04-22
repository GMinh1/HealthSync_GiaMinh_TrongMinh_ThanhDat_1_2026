class HealthRecord {
  String id;
  String name;
  int age;
  double weight;
  double height;

  HealthRecord(this.id, this.name, this.age, this.weight, this.height);

  // Hiển thị thông tin
  void displayInfo() {
    print("ID: $id");
    print("Name: $name");
    print("Age: $age");
    print("Weight: $weight kg");
    print("Height: $height m");
    print("BMI: ${calculateBMI()}");
    print("----------------------");
  }

  // Tính BMI
  double calculateBMI() {
    return weight / (height * height);
  }

  // Cập nhật thông tin
  void updateInfo(String name, int age, double weight, double height) {
    this.name = name;
    this.age = age;
    this.weight = weight;
    this.height = height;
  }
}