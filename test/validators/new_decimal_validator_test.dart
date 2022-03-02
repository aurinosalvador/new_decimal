import 'package:flutter_test/flutter_test.dart';
import 'package:new_decimal/util/decimal.dart';
import 'package:new_decimal/validators/new_decimal_validator.dart';

///
///
///
void main() {
  final NewDecimalValidator validator = NewDecimalValidator(4);

  ///
  ///
  ///
  Map<String, Decimal> parseTests = <String, Decimal>{
    '0': Decimal(precision: 4, doubleValue: 0),
    '0,0': Decimal(precision: 4, doubleValue: 0),
    '0,01': Decimal(precision: 4, doubleValue: 0.01),
    '0,001': Decimal(precision: 4, doubleValue: 0.001),
    '0,0001': Decimal(precision: 4, doubleValue: 0.0001),
    '0,00011': Decimal(precision: 4, doubleValue: 0.0001),
    '0,00015': Decimal(precision: 4, doubleValue: 0.0001),
    '0,00019': Decimal(precision: 4, doubleValue: 0.0001),
    ',0': Decimal(precision: 4, doubleValue: 0),
    ',01': Decimal(precision: 4, doubleValue: 0.01),
    ',001': Decimal(precision: 4, doubleValue: 0.001),
    ',0001': Decimal(precision: 4, doubleValue: 0.0001),
    ',00009': Decimal(precision: 4, doubleValue: 0),
    '1,0000': Decimal(precision: 4, doubleValue: 1),
    '0,1000': Decimal(precision: 4, doubleValue: 0.1),
    '0,1100': Decimal(precision: 4, doubleValue: 0.11),
    '0,1110': Decimal(precision: 4, doubleValue: 0.111),
    '0,1111': Decimal(precision: 4, doubleValue: 0.1111),
    '0,11111': Decimal(precision: 4, doubleValue: 0.1111),
    '0,11115': Decimal(precision: 4, doubleValue: 0.1111),
    '0,11119': Decimal(precision: 4, doubleValue: 0.1111),
    '1': Decimal(precision: 4, doubleValue: 1),
    '1,0': Decimal(precision: 4, doubleValue: 1),
    '1,1': Decimal(precision: 4, doubleValue: 1.1),
    '1,01': Decimal(precision: 4, doubleValue: 1.01),
    '1,001': Decimal(precision: 4, doubleValue: 1.001),
    '1,0001': Decimal(precision: 4, doubleValue: 1.0001),
    '1,00001': Decimal(precision: 4, doubleValue: 1),
    '1,00005': Decimal(precision: 4, doubleValue: 1),
    '1,00009': Decimal(precision: 4, doubleValue: 1),
  };

  group('NewDecimalValidator parse', () {
    for (MapEntry<String, Decimal> input in parseTests.entries) {
      test(
        'Testing: ${input.key}',
        () => expect(validator.parse(input.key), input.value),
      );
    }
  });

  ///
  ///
  ///
  Map<Decimal, String> formatTest = <Decimal, String>{
    Decimal(precision: 4, doubleValue: 0): '0,0000',
    Decimal(precision: 4, doubleValue: 0.1): '0,1000',
    Decimal(precision: 4, doubleValue: 0.01): '0,0100',
    Decimal(precision: 4, doubleValue: 0.001): '0,0010',
    Decimal(precision: 4, doubleValue: 0.0001): '0,0001',
    Decimal(precision: 4, doubleValue: 0.00001): '0,0000',
    Decimal(precision: 4, doubleValue: 0.00004): '0,0000',
    Decimal(precision: 4, doubleValue: 0.00005): '0,0001',
    Decimal(precision: 4, doubleValue: 0.00009): '0,0001',
    Decimal(precision: 4, doubleValue: 1): '1,0000',
    Decimal(precision: 4, doubleValue: 1.1): '1,1000',
    Decimal(precision: 4, doubleValue: 1.11): '1,1100',
    Decimal(precision: 4, doubleValue: 1.111): '1,1110',
    Decimal(precision: 4, doubleValue: 1.1111): '1,1111',
    Decimal(precision: 4, doubleValue: 1.11111): '1,1111',
    Decimal(precision: 4, doubleValue: 1.11114): '1,1111',
    Decimal(precision: 4, doubleValue: 1.11115): '1,1112',
    Decimal(precision: 4, doubleValue: 1.11119): '1,1112',
  };

  group('NewDecimalValidator format', () {
    for (MapEntry<Decimal, String> input in formatTest.entries) {
      test(
        'Testing: ${input.key}',
        () => expect(validator.format(input.key), input.value),
      );
    }
  });
}
