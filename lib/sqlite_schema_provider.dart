import 'schema/model_definition.dart';

class SqliteSchemaProvider {
  String createTable(ModelDefinition model) {
    final table = model.table!;
    final buffer = StringBuffer();

    buffer.write('CREATE TABLE IF NOT EXISTS ');
    buffer.write(model.tableName);
    buffer.write(' (');

    final columns = <String>[];

    table.columns.forEach((name, type) {
      columns.add('$name $type');
    });

    if (table.primaryKey.isNotEmpty) {
      columns.add('PRIMARY KEY (${table.primaryKey.join(', ')})');
    }

    buffer.write(columns.join(', '));
    buffer.write(');');

    return buffer.toString();
  }

  List<String> createIndexes(ModelDefinition model) {
    return model.indexes.map((index) {
      final unique = index.unique ? 'UNIQUE ' : '';
      return '''
CREATE ${unique}INDEX IF NOT EXISTS
${index.indexName(model.tableName)}
ON ${model.tableName} (${index.columns.join(', ')});
''';
    }).toList();
  }
}
