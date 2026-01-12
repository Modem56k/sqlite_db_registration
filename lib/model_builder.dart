import 'fields/field_accessor.dart';
import 'schema/index_definition.dart';
import 'schema/model_definition.dart';
import 'schema/table_definition.dart';

class ModelBuilder<T> {
  final ModelDefinition definition;

  ModelBuilder(String tableName, {int version = 1})
    : definition = ModelDefinition(
        type: T,
        tableName: tableName,
        version: version,
      );

  ModelBuilder<T> table({
    required Fields<T> fields,
    required List<Field> primaryKey,
  }) {
    final columns = <String, String>{};

    for (final field in fields.all) {
      columns[field.name] = _buildColumnDefinition(field);
    }

    definition.table = TableDefinition(
      columns: columns,
      primaryKey: primaryKey.map((f) => f.name).toList(),
    );

    return this;
  }

  String _buildColumnDefinition(Field field) {
    final buffer = StringBuffer('${field.type}');

    if (!field.nullable) {
      buffer.write(' NOT NULL');
    }

    if (field.defaultValue != null) {
      buffer.write(' DEFAULT ${field.defaultValue}');
    }

    return buffer.toString();
  }

 ModelBuilder<T> index(List<Field> fields) {
  definition.indexes.add(
    IndexDefinition(
      columns: fields.map((f) => f.name).toList(),
    ),
  );
  return this;
}

ModelBuilder<T> unique(List<Field> fields) {
  definition.indexes.add(
    IndexDefinition(
      columns: fields.map((f) => f.name).toList(),
      unique: true,
    ),
  );
  return this;
}
}
