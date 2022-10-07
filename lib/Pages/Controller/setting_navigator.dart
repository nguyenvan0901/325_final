import 'package:flutter/material.dart';
import 'package:my_app/Pages/View/settings.dart';

// This file contains all the pathing for setting pages

class SettingNavigator extends StatefulWidget {
  const SettingNavigator({super.key});

  @override
  State<SettingNavigator> createState() => _SettingNavigatorState();
}

class _SettingNavigatorState extends State<SettingNavigator> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/': (context) => const Setting(),
    });
  }
}
