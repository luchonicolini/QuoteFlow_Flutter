import 'package:intl/intl.dart';

/// Currency amount stored as integer minor units.
///
/// Arithmetic never uses floating point and rejects mixed currencies. Decimal
/// representation is created only at the formatting boundary.
class Money {
  const Money({required this.amountMinor, required this.currency})
    : assert(amountMinor >= 0, 'Amount must be non-negative'),
      assert(currency.length == 3, 'Currency must be an ISO 4217 code');

  final int amountMinor;
  final String currency;

  /// ISO 4217 minor-unit precision for common currencies.
  /// Unknown currencies default to two decimal places.
  int get decimalPlaces => _currencyDecimalPlaces[currency.toUpperCase()] ?? 2;

  static const _currencyDecimalPlaces = <String, int>{
    'BHD': 3,
    'CLF': 4,
    'CLP': 0,
    'DJF': 0,
    'GNF': 0,
    'ISK': 0,
    'JPY': 0,
    'KMF': 0,
    'KRW': 0,
    'KWD': 3,
    'LYD': 3,
    'OMR': 3,
    'PYG': 0,
    'TND': 3,
    'UGX': 0,
    'UYI': 0,
    'VND': 0,
    'VUV': 0,
    'XAF': 0,
    'XOF': 0,
    'XPF': 0,
  };

  Money operator +(Money other) {
    _ensureSameCurrency(other);
    return Money(
      amountMinor: amountMinor + other.amountMinor,
      currency: currency,
    );
  }

  Money operator -(Money other) {
    _ensureSameCurrency(other);
    final result = amountMinor - other.amountMinor;
    if (result < 0) {
      throw StateError('Resulting money amount cannot be negative');
    }
    return Money(amountMinor: result, currency: currency);
  }

  void _ensureSameCurrency(Money other) {
    if (currency.toUpperCase() != other.currency.toUpperCase()) {
      throw ArgumentError(
        'Cannot combine different currencies: $currency and ${other.currency}',
      );
    }
  }

  /// Formats without converting the stored value to `double`.
  String format({String? locale}) {
    final digits = decimalPlaces;
    final divisor = _powerOfTen(digits);
    final whole = amountMinor ~/ divisor;
    final fraction = amountMinor.remainder(divisor);
    final symbols = NumberFormat.decimalPattern(locale).symbols;
    final groupingFormat = NumberFormat.decimalPattern(locale)
      ..minimumFractionDigits = 0
      ..maximumFractionDigits = 0;
    final wholeText = groupingFormat.format(whole);
    final fractionText = digits == 0
        ? ''
        : '${symbols.DECIMAL_SEP}${fraction.toString().padLeft(digits, '0')}';
    return '$currency $wholeText$fractionText';
  }

  static int _powerOfTen(int exponent) {
    var value = 1;
    for (var i = 0; i < exponent; i++) {
      value *= 10;
    }
    return value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Money &&
          amountMinor == other.amountMinor &&
          currency.toUpperCase() == other.currency.toUpperCase();

  @override
  int get hashCode => Object.hash(amountMinor, currency.toUpperCase());

  @override
  String toString() => format();
}
