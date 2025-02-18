import 'package:betalent_employees_app/domain/entities/employee_entity.dart';
import 'package:betalent_employees_app/domain/usecases/get_employees.dart';
import 'package:flutter/material.dart';

class EmployeeController {
  final GetEmployees getEmployees;

  final ValueNotifier<List<EmployeeEntity>> employees = ValueNotifier([]);
  final ValueNotifier<String?> error = ValueNotifier(null);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  EmployeeController(this.getEmployees);

  Future<void> loadEmployees() async {
    isLoading.value = true;
    error.value = null;

    final result = await getEmployees();

    result.fold(
      (failure) => error.value = failure.message,
      (employeesList) => employees.value = employeesList,
    );

    isLoading.value = false;
  }
}
