import 'package:betalent_employees_app/core/error/failures.dart';
import 'package:betalent_employees_app/domain/entities/employee_entity.dart';
import 'package:betalent_employees_app/domain/repositories/employee_repository.dart';
import 'package:dartz/dartz.dart';

class GetEmployees {
  final EmployeeRepository repository;

  GetEmployees(this.repository);

  Future<Either<Failure, List<EmployeeEntity>>> call() async {
    try {
      return await repository.getEmployees();
    } catch (e) {
      return Left(ServerFailure('Erro ao buscar funcionários: $e'));
    }
  }
}
