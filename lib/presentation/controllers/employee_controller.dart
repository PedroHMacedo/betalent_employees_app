import 'package:betalent_employees_app/domain/entities/employee_entity.dart';
import 'package:betalent_employees_app/domain/usecases/get_employees.dart';
import 'package:flutter/material.dart';

class EmployeeController {
  final GetEmployees getEmployees;

  final ValueNotifier<List<EmployeeEntity>> employees = ValueNotifier([]);
  final ValueNotifier<String?> error = ValueNotifier(null);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  final ValueNotifier<List<EmployeeEntity>> filteredEmployees = ValueNotifier(
    [],
  );
  final ValueNotifier<String> searchQuery = ValueNotifier('');

  EmployeeController(this.getEmployees);

  Future<void> loadEmployees() async {
    isLoading.value = true;
    error.value = null;

    final result = await getEmployees();

    result.fold(
      (failure) {
        error.value =
            'Ocorreu um erro!\nNão foi possível buscar os funcionários';
        isLoading.value = false;
      },
      (employeesList) {
        employees.value = employeesList;
        filteredEmployees.value = employeesList;
      },
    );

    isLoading.value = false;
  }

  void _filterEmployees() {
    if (searchQuery.value.isEmpty) {
      filteredEmployees.value = List.from(employees.value);
      return;
    }

    final query = searchQuery.value.toLowerCase();
    filteredEmployees.value =
        employees.value.where((employee) {
          return employee.name.toLowerCase().contains(query) ||
              employee.job.toLowerCase().contains(query) ||
              employee.phone.contains(query);
        }).toList();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    _filterEmployees();
  }
}
