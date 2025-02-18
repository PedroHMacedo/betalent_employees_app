import '../../domain/entities/employee_entity.dart';

class EmployeeModel extends EmployeeEntity {
  EmployeeModel({
    required super.id,
    required super.name,
    required super.job,
    required super.admissionDate,
    required super.phone,
    required super.image,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      name: json['name'],
      job: json['job'],
      admissionDate: json['admission_date'],
      phone: json['phone'],
      image: json['image'],
    );
  }
}
