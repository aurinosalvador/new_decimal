import 'package:flutter/material.dart';
import 'package:new_decimal/util/decimal.dart';
import 'package:new_decimal/validators/new_decimal_validator.dart';

///
///
///
class NewDecimalField extends StatefulWidget {
  final NewDecimalEditingController? controller;
  final Decimal? initialValue;
  final TextAlign textAlign;
  final FocusNode? focusNode;
  final void Function(Decimal)? lostFocus;

  ///
  ///
  ///
  const NewDecimalField({
    this.controller,
    this.initialValue,
    this.textAlign = TextAlign.end,
    this.focusNode,
    this.lostFocus,
    Key? key,
  })  : assert(initialValue == null || controller == null,
            'initialValue or controller must be null.'),
        super(key: key);

  ///
  ///
  ///
  @override
  NewDecimalFieldState createState() => NewDecimalFieldState();
}

///
///
///
class NewDecimalFieldState extends State<NewDecimalField> {
  NewDecimalEditingController? _controller;
  FocusNode? _focusNode;

  ///
  ///
  ///
  NewDecimalEditingController get _effectiveController =>
      widget.controller ?? _controller!;

  ///
  ///
  ///
  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode!;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = NewDecimalEditingController(widget.initialValue!);
    }

    if (widget.focusNode == null) {
      _focusNode = FocusNode();
    }

    _effectiveFocusNode.addListener(_handleFocus);
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: widget.textAlign,
      controller: _effectiveController,
      focusNode: _effectiveFocusNode,
      keyboardType: _effectiveController.validator.keyboard,
      minLines: 1,
      inputFormatters: _effectiveController.validator.inputFormatters,
      autocorrect: false,
      enableSuggestions: false,
    );
  }

  ///
  ///
  ///
  void _handleFocus() {
    if (_effectiveFocusNode.hasFocus) {
      _effectiveController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _effectiveController.text.length,
      );
    } else {
      widget.lostFocus?.call(_effectiveController.decimal);
    }
  }

  ///
  ///
  ///
  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocus);

    if (_controller != null) {
      _controller!.dispose();
    }

    if (_focusNode != null) {
      _focusNode!.dispose();
    }

    super.dispose();
  }
}

///
///
///
class NewDecimalEditingController extends TextEditingController {
  final NewDecimalValidator validator;

  ///
  ///
  ///
  NewDecimalEditingController(Decimal value)
      : validator = NewDecimalValidator(value.precision) {
    decimal = value;
    addListener(_changeListener);
  }

  ///
  ///
  ///
  void _changeListener() {
    print('S ===========');

    if (text.isEmpty) {
      decimal = Decimal(precision: validator.precision);
      selection = TextSelection.collapsed(
        offset: text.length -
            validator.precision -
            validator.decimalSeparator.length,
      );
      print('F2 ==========');
      return;
    }

    print('- Text: $text');

    int sepPos = text.indexOf(validator.decimalSeparator);
    print('Sep Pos: $sepPos');

    if (sepPos < 0) {
      decimal = parse(
        text + List<String>.generate(validator.precision, (_) => '0').join(),
      );
      selection = TextSelection.collapsed(
        offset: text.length -
            validator.precision -
            validator.decimalSeparator.length,
      );
      print('F3 ==========');
      return;
    }

    int pos = selection.baseOffset;
    print('Position: $pos');

    if (pos < sepPos + 1) {
      // Parte Inteira
      print('Parte Inteira');
      Decimal newDecimal = parse(text);
      String newText = format(newDecimal);

      print('Lenght old: ${text.length} // Length new: ${newText.length}');

      decimal = newDecimal;
    } else {
      // Parte Decimal
      print('Parte Decimal');
      if (pos > 0) {
        String lastChar = text.characters.elementAt(pos - 1);
        print('Last Char: $lastChar');
        // decimal = parse(text);
      }
    }

    print('F1 ==========');
  }

  ///
  ///
  ///
  set decimal(Decimal dec) {
    String masked = format(dec);
    if (masked != text) {
      text = masked;
    }
  }

  ///
  ///
  ///
  Decimal get decimal => parse(text);

  ///
  ///
  ///
  Decimal parse(String? text) =>
      validator.parse(text) ?? Decimal(precision: validator.precision);

  ///
  ///
  ///
  String format(Decimal decimal) => validator.format(decimal);

  ///
  ///
  ///
  @override
  void dispose() {
    removeListener(_changeListener);
    super.dispose();
  }
}
