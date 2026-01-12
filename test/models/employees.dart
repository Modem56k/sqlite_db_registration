import 'package:sqlite_db_registration/fields/field_accessor.dart';

class Employee {
  final int id;

  final int employeeId;
  final DateTime createdAt;

  Employee(this.id, this.employeeId, this.createdAt);
}

class EmployeeFields extends Fields<Employee> {
  EmployeeFields();

  final id = Field.integer('id', nullable: false);
  final employeeId = Field.integer('employee_id');
  final createdAt = Field.dateTime('created_at');

  @override
  List<Field> get all => [id, employeeId, createdAt];
  
}