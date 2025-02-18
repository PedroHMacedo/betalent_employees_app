import 'package:betalent_employees_app/core/error/failures.dart';
import 'package:betalent_employees_app/domain/entities/employee_entity.dart';
import 'package:dartz/dartz.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, List<EmployeeEntity>>> getEmployees();
}
