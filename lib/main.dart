import 'package:flutter/material.dart';
import 'package:new_decimal/fields/new_decimal_field.dart';
import 'package:new_decimal/util/decimal.dart';

///
///
///
void main() {
  runApp(const MyApp());
}

///
///
///
class MyApp extends StatelessWidget {
  ///
  ///
  ///
  const MyApp({Key? key}) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

///
///
///
class MyHomePage extends StatefulWidget {
  ///
  ///
  ///
  const MyHomePage({Key? key}) : super(key: key);

  ///
  ///
  ///
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

///
///
///
class _MyHomePageState extends State<MyHomePage> {
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Decimal'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: NewDecimalField(
            initialValue: Decimal(
              precision: 4,
              doubleValue: 234,
            ),
            lostFocus: (Decimal decimal) {
              print('Decimal Lost Focus: ${decimal.doubleValue}');
            },
          ),
        ),
      ),
    );
  }
}
