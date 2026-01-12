
import 'model_builder.dart';
import 'registry.dart';
import 'schema/model_definition.dart';

class ResourceRegistry implements Registry {
  final List<ModelDefinition> _models = [];

  ModelBuilder<T> forModel<T>({
    required String tableName,
    int version = 1,
  }) {
    final builder = ModelBuilder<T>(tableName, version: version);
    _models.add(builder.definition);
    return builder;
  }

  @override
  List<ModelDefinition> get models => _models;
}
