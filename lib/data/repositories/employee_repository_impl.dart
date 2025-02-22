import 'package:betalent_employees_app/core/error/failures.dart';
import 'package:betalent_employees_app/core/http_client/http_client.dart';
import 'package:betalent_employees_app/data/models/employee_model.dart';
import 'package:betalent_employees_app/domain/entities/employee_entity.dart';
import 'package:betalent_employees_app/domain/repositories/employee_repository.dart';
import 'package:dartz/dartz.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final HttpClient client;

  EmployeeRepositoryImpl(this.client);

  @override
  Future<Either<Failure, List<EmployeeEntity>>> getEmployees() async {
    try {
      final response = await client.get('http://192.168.68.101:3000/employees');
      final List<EmployeeModel> employees =
          (response).map((json) => EmployeeModel.fromJson(json)).toList();
      return Right(employees);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
