import 'package:sqflite/sqlite_api.dart';
import 'registry.dart';
import 'sqlite_schema_provider.dart';

class SqliteDatabaseInitializer {
  final Database db;
  final SqliteSchemaProvider provider;

  SqliteDatabaseInitializer(this.db, this.provider);

  Future<void> ensureCreated(Registry registry) async {
    for (final model in registry.models) {
      await db.execute(provider.createTable(model));

      for (final sql in provider.createIndexes(model)) {
        await db.execute(sql);
      }
    }
  }
}
