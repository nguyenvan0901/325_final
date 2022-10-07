import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_app/Pages/Model/barcode_scanner.dart';

// This screen is the first screen users see when they want to add a button.
// It contains multiple food suggestions for users to add and also a button
// for users to open the barcode scanner.

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  int currentPage = 1;
  String imagePath = 'assets/banana.jpeg';
  File? image;
  String? itemName = "";
  var itemDetails = {};
  CodeScanner cs = CodeScanner();

  // Push the current screen to the camera screen and loading screen
  void scanBarCode() async {
    Navigator.pushReplacementNamed(context, '/loading');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar Component
      appBar: AppBar(
        title: const Text('Add Food'),
        backgroundColor: Colors.green,
      ),

      // Single Child Scroll View component
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),

          // Column component
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // SizedBox component
                const SizedBox(height: 30),

                // Text component
                const Text("Commonly added food:",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
                foodSuggestion("Banana", 90.0, 23, 1.1, 0.3),
                const SizedBox(height: 10),
                foodSuggestion("Rice Jasmine", 480.0, 108, 9, 1.5),
                const SizedBox(height: 10),
                foodSuggestion("White bread", 260.0, 50, 8, 3),
                const SizedBox(height: 10),
                foodSuggestion("Blue milk", 70.0, 5, 3.4, 3.8),
                const SizedBox(height: 10),
                foodSuggestion("Apple", 100.0, 27.6, 0.5, 0.3),
                const SizedBox(height: 10),
                foodSuggestion("Streaky Bacon", 315, 2.5, 14.2, 28),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),

                  // ElevatedButton with Icon component
                  child: ElevatedButton.icon(
                      style: elevatedButtonStyle(),
                      onPressed: () => scanBarCode(),

                      // Icon component
                      icon: const Icon(Icons.document_scanner_outlined),
                      label: const Text("Open barcode scanner")),
                ),
              ]),
        ),
      ),
    );
  }

  // This function returns a BoxDecoration which is a decoration for the border
  // container used in this page.
  BoxDecoration boxdecor() {
    return BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(width: 2, color: Colors.grey),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ));
  }

  // This function retursns the style of all buttons on this page.
  ButtonStyle elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(50),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    );
  }

  // This function creates a container that to contain commond food in this page
  Container foodSuggestion(
      String name, double calo, double carbs, double proteins, double fats) {
    return Container(
      decoration: boxdecor(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name),
                  Text("Calories: $calo, Carb: $carbs",
                      style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                  Text("Protein: $proteins, fat: $fats",
                      style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                ]),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                onPressed: () => pushNewPageWithFoodSuggestion(
                    name, calo, carbs, proteins, fats),
                child: const Icon(Icons.add)),
          ],
        ),
      ),
    );
  }

  // This function handles the navigation from add screen to the nutriment
  // details screen.
  void pushNewPageWithFoodSuggestion(
      String name, double calo, double carbs, double proteins, double fats) {
    Navigator.pushReplacementNamed(context, '/details', arguments: {
      'name': name,
      'calories per serve': calo * 4,
      'carbohydrate per serve': carbs,
      'protein per serve': proteins,
      'fat per serve': fats,
      'saturated fat per serve': 0,
      'salt per serve': 0,
      'sugar per serve': 0,
    });
  }
}
