import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:new_decimal/util/decimal.dart';
import 'package:new_decimal/validators/abstract_validator.dart';

///
///
///
class NewDecimalValidator extends AbstractValidator<Decimal>
    implements AbstractParser<Decimal> {
  final int precision;
  final String decimalSeparator;
  final String thousandSeparator;

  ///
  ///
  ///
  NewDecimalValidator(
    this.precision, {
    this.decimalSeparator = ',',
    this.thousandSeparator = '.',
  })  : assert(
            precision >= 0, 'precision must be equals or greater than zero.'),
        super(<TextInputFormatter>[
          FilteringTextInputFormatter.allow(
            RegExp('[0-9$decimalSeparator]'),
          ),
        ]);

  ///
  ///
  ///
  @override
  TextInputType get keyboard => TextInputType.number;

  ///
  ///
  ///
  @override
  String strip(String value) {
    if (kDebugMode) {
      print('Decimal validator - call strip method.');
    }
    return value;
  }

  ///
  ///
  ///
  String _internalStrip(String value) => super.strip(value);

  ///
  ///
  ///
  @override
  String format(Decimal decimal) {
    List<String> parts = decimal.doubleValue
        .toStringAsFixed(precision)
        .replaceAll('.', '')
        .split('')
        .reversed
        .toList();

    int start = precision + 4;
    if (precision > 0) {
      parts.insert(precision, decimalSeparator);
    } else {
      start = 3;
    }

    for (int i = start; parts.length > i; i += 4) {
      parts.insert(i, thousandSeparator);
    }

    String masked = parts.reversed.join();

    return masked;
  }

  ///
  ///
  ///
  @override
  bool isValid(String decimal) => valid(decimal) == null;

  ///
  ///
  ///
  @override
  Decimal? parse(String? value) {
    Decimal decimal = Decimal(precision: precision);

    if (value == null || value.isEmpty) {
      return decimal;
    }

    int sepPos = value.indexOf(decimalSeparator);

    String integerPart = '0';
    String decimalPart = '0';

    if (sepPos < 0) {
      integerPart = value;
    } else if (sepPos == 0) {
      decimalPart = _internalStrip(value);
    } else {
      integerPart = _internalStrip(value.substring(0, sepPos));
      decimalPart = _internalStrip(value.substring(sepPos));
    }

    if (decimalPart.length > precision) {
      decimalPart = decimalPart.substring(0, precision);
    }

    String s = '$integerPart.$decimalPart';

    double? d = double.tryParse(s);

    if (d == null) {
      if (kDebugMode) {
        print('Error to parse $s');
      }
      d = 0;
    }

    decimal.doubleValue = d;

    return decimal;
  }

  ///
  ///
  ///
  @override
  String? valid(String value) => null;
}
