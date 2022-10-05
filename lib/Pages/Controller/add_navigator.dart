import 'package:flutter/material.dart';
import 'package:my_app/Pages/View/loading.dart';

import '../View/details.dart';
import '../View/add_item.dart';

class AddNavigator extends StatefulWidget {
  const AddNavigator({super.key});

  @override
  State<AddNavigator> createState() => _AddNavigatorState();
}

class _AddNavigatorState extends State<AddNavigator> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/': (context) => const Add(),
      '/loading': (context) => const LoadingScreen(),
      '/details': (context) => const Details(),
    });
  }
}
