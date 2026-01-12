import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqlite_db_registration/dynamic_db.dart';
import 'models/employees.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late Database db;

  setUp(() async {
    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
  });

  tearDown(() async {
    await db.close();
  });

  test('creates table and indexes from registry', () async {
    // initilize modles for storage
    final fields = EmployeeFields();

    // registering tables and models
    final registry = ResourceRegistry()
      ..forModel<Employee>(tableName: 'employees')
          .table(fields: fields, primaryKey: [fields.id])
          .index([fields.employeeId])
          .unique([fields.employeeId, fields.createdAt]);

    // database and table initilizer based on registeries..
    final initializer = SqliteDatabaseInitializer(db, SqliteSchemaProvider());
    await initializer.ensureCreated(registry);

    // insert single record to verify table works
    await db.insert(
      'employees',
      {
        fields.id: 1,
        fields.employeeId: 123,
        fields.createdAt: DateTime.now().toIso8601String(),
      }.toSqliteMap(),
    );

    // ---- verify table exists
    final tables = await db.rawQuery('''
    SELECT name FROM sqlite_master
    WHERE type = 'table' AND name = 'employees';
  ''');

    expect(tables.length, 1);

    // ---- verify columns
    final columns = await db.rawQuery('PRAGMA table_info(employees);');
    final columnNames = columns.map((c) => c['name'] as String).toList();

    expect(columnNames, containsAll(['id', 'employee_id', 'created_at']));

    // ---- verify indexes
    final indexes = await db.rawQuery('PRAGMA index_list(employees);');
    final indexNames = indexes.map((i) => i['name'] as String).toList();

    var result = await db.query('employees');
    // Dummy query to avoid unused variable warning
    print(result); // Output to console

    expect(
      result,
      isNotEmpty,
      reason: 'The employees table should have at least one record',
    ); // Simple check to ensure query worked

    print('The value being tested is: $indexNames'); // Output to console

    expect(
      indexNames,
      containsAll([
        'idx_employees_employee_id',
        'idx_employees_employee_id_created_at',
      ]),
    );
  });
}
