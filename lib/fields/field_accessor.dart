import 'field_types.dart';

class Field<T> {
  /// Column name in the database.
  final String name;

  /// SQLite column type.
  final String type;

  /// Whether the column allows NULL values.
  final bool nullable;

  /// Optional default SQL value.
  final String? defaultValue;

  /// Creates a const instance of a field descriptor.
  ///
  /// Field definitions are immutable and intended to be reused.
  const Field._(
    this.name,
    this.type, {
    this.nullable = true,
    this.defaultValue,
  });

  // ---- Factory constructors for common types ----
  static Field integer(
    String name, {
    bool nullable = true,
    String? defaultValue,
  }) => Field._(
    name,
    FieldType.integer,
    nullable: nullable,
    defaultValue: defaultValue,
  );

  static Field real(
    String name, {
    bool nullable = true,
    String? defaultValue,
  }) => Field._(
    name,
    FieldType.real,
    nullable: nullable,
    defaultValue: defaultValue,
  );

  static Field text(
    String name, {
    bool nullable = true,
    String? defaultValue,
  }) => Field._(
    name,
    FieldType.text,
    nullable: nullable,
    defaultValue: defaultValue,
  );

  static Field dateTime(String name, {bool nullable = true}) =>
      Field._(name, FieldType.dateTime, nullable: nullable);

  static Field boolean(
    String name, {
    bool nullable = true,
    bool defaultValue = false,
  }) => Field._(
    name,
    FieldType.boolean,
    nullable: nullable,
    defaultValue: defaultValue ? '1' : '0',
  );
}

/// Base class for defining typed SQLite field descriptors.
///
/// Subclasses define `Field` instances that describe column
/// names and types for a model.
abstract class Fields<T> {
  const Fields();

  /// Returns all fields defined for this model.
  ///
  /// Subclasses must override this to expose their fields.
  List<Field> get all;
}