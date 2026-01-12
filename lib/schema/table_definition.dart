class TableDefinition {
  final List<String> primaryKey;
  final Map<String, String> columns;

  TableDefinition({
    required this.primaryKey,
    required this.columns,
  });
}