import 'package:flutter/material.dart';
import 'package:my_app/Pages/View/summary.dart';

// This file contains all the pathing for summary pages

class SummaryNavigator extends StatefulWidget {
  const SummaryNavigator({super.key});

  @override
  State<SummaryNavigator> createState() => _SummaryNavigatorState();
}

class _SummaryNavigatorState extends State<SummaryNavigator> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/': (context) => const Summary(),
    });
  }
}
