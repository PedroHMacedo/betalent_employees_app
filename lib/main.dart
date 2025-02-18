import 'package:betalent_employees_app/presentation/pages/employees_page.dart';
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'core/http_client/http_client.dart';
import 'data/repositories/employee_repository_impl.dart';
import 'domain/usecases/get_employees.dart';
import 'presentation/controllers/employee_controller.dart';

void main() {
  final httpClient = HttpClientImpl();
  final repository = EmployeeRepositoryImpl(httpClient);
  final getEmployees = GetEmployees(repository);
  final controller = EmployeeController(getEmployees);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Management',
      theme: AppTheme.lightTheme,
      home: EmployeesPage(controller: controller),
    ),
  );
}
