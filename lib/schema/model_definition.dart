import 'index_definition.dart';
import 'table_definition.dart';

class ModelDefinition {
  final Type type;
  final String tableName;
  final int version;

  TableDefinition? table;
  final List<IndexDefinition> indexes = [];

  ModelDefinition({
    required this.type,
    required this.tableName,
    this.version = 1,
  });
}
