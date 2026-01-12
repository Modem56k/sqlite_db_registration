/// Defines SQLite column type constants and common aliases.
///
/// SQLite uses dynamic typing with *type affinity* rather than strict
/// column types. The values in this class map to SQLite's supported
/// storage classes or commonly used declared type aliases.
///
/// These constants are intended for schema definition only and do not
/// imply runtime type enforcement by SQLite.
class FieldType {
  // ---- Core SQLite storage classes ----

  /// SQLite INTEGER storage class.
  ///
  /// Used for integers, booleans (0/1), and integer-based timestamps.
  static const integer = 'INTEGER';

  /// SQLite REAL storage class.
  ///
  /// Used for floating-point numbers.
  static const real = 'REAL';

  /// SQLite TEXT storage class.
  ///
  /// Used for strings, ISO-8601 dates, JSON, and UUIDs.
  static const text = 'TEXT';

  /// SQLite BLOB storage class.
  ///
  /// Used for binary data such as images or serialized objects.
  static const blob = 'BLOB';

  /// SQLite NUMERIC affinity.
  ///
  /// SQLite will choose INTEGER or REAL depending on the stored value.
  static const numeric = 'NUMERIC';

  // ---- Common semantic aliases (documentation-level only) ----

  /// Boolean value stored as INTEGER (0 = false, 1 = true).
  static const boolean = 'INTEGER';

  /// Date value stored as TEXT (ISO-8601 format recommended).
  static const date = 'TEXT';

  /// Date and time value stored as TEXT (ISO-8601 format recommended).
  static const dateTime = 'TEXT';

  /// Timestamp stored as INTEGER (epoch milliseconds or seconds).
  static const timestamp = 'INTEGER';

  /// JSON data stored as TEXT.
  static const json = 'TEXT';

  /// UUID value stored as TEXT.
  static const uuid = 'TEXT';

  /// Variable-length character data stored as TEXT.
  static const varchar = 'TEXT';

  /// Decimal or fixed-point numeric value stored using NUMERIC affinity.
  static const decimal = 'NUMERIC';
}
