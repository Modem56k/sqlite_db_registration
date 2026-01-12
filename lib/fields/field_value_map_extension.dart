import 'field_accessor.dart';

extension FieldValueMap on Map<Field, Object?> {
  Map<String, Object?> toSqliteMap() {
    return map((field, value) => MapEntry(field.name, value));
  }
}