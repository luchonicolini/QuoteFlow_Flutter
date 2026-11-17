import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:scopeguard/core/domain/value_objects/money.dart';

void main() async {
  await initializeDateFormatting();
  group('Money', () {
    test('formats two-decimal currency without float arithmetic', () {
      const money = Money(amountMinor: 15000, currency: 'USD');
      expect(money.format(), contains('150.00'));
    });

    test('formats currencies with zero and three minor-unit decimals', () {
      expect(
        const Money(amountMinor: 123, currency: 'JPY').format(),
        'JPY 123',
      );
      expect(
        const Money(
          amountMinor: 1234567,
          currency: 'KWD',
        ).format(locale: 'en_US'),
        'KWD 1,234.567',
      );
      expect(
        const Money(
          amountMinor: 1234567,
          currency: 'KWD',
        ).format(locale: 'es_AR'),
        'KWD 1.234,567',
      );
    });

    test('adds same-currency values and rejects mixed currencies', () {
      const first = Money(amountMinor: 1000, currency: 'USD');
      const second = Money(amountMinor: 500, currency: 'USD');
      expect((first + second).amountMinor, 1500);
      expect(
        () => first + const Money(amountMinor: 500, currency: 'EUR'),
        throwsArgumentError,
      );
    });

    test('rejects negative results', () {
      expect(
        () =>
            const Money(amountMinor: 100, currency: 'USD') -
            const Money(amountMinor: 101, currency: 'USD'),
        throwsStateError,
      );
    });
  });
}
