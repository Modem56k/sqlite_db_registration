class IndexDefinition {
  final List<String> columns;
  final bool unique;

  IndexDefinition({
    required this.columns,
    this.unique = false,
  });

  String indexName(String tableName) {
    final cols = columns.join('_');
    return 'idx_${tableName}_$cols';
  }
}