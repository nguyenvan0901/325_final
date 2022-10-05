import 'package:flutter/material.dart';
import 'package:my_app/Pages/View/record.dart';

class RecordNavigator extends StatefulWidget {
  const RecordNavigator({super.key});

  @override
  State<RecordNavigator> createState() => _RecordNavigatorState();
}

class _RecordNavigatorState extends State<RecordNavigator> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/': (context) => const Record(),
    });
  }
}
