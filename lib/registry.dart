import 'schema/model_definition.dart';

abstract class Registry {
  List<ModelDefinition> get models;
}