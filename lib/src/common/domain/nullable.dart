class Nullable<T> {
  final T _value;
  final bool _hasValue;

  /// Creates a Nullable instance holding a non-null value.
  factory Nullable(T value) => Nullable._(value, true);

  const Nullable._(this._value, this._hasValue);

  /// Creates a Nullable instance representing 'null'.
  static const none = Nullable._(null, false);

  T? get value => _hasValue ? _value : null;
  bool get hasValue => _hasValue;
}
