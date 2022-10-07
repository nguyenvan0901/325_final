import 'package:flutter/material.dart';
import 'package:my_app/Pages/Controller/add_navigator.dart';
import 'package:my_app/Pages/Controller/record_navigator.dart';
import 'package:my_app/Pages/Controller/setting_navigator.dart';
import 'package:my_app/Pages/Controller/summary_navigator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void testFunction() {}
  final screens = [
    const RecordNavigator(),
    const AddNavigator(),
    const SummaryNavigator(),
    const SettingNavigator(),
  ];
  int currentPage = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentPage],

      // NavigationBar component
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPage,
        onDestinationSelected: (currentPage) =>
            {setState(() => this.currentPage = currentPage)},
        destinations: const [
          NavigationDestination(icon: Icon(Icons.menu_book), label: "Record"),
          NavigationDestination(icon: Icon(Icons.add_circle), label: "Add"),
          NavigationDestination(icon: Icon(Icons.summarize), label: "Summary"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Setting"),
        ],
      ),
    );
  }
}
