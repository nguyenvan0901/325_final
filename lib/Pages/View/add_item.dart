// This screen is the main screen where users can use phone camera or gallary
// to take photo of the fruit

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/Pages/Model/barcode_scanner.dart';

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

  void scanBarCode() async {
    // await cs.openBarCodeScanner();
    // print("done sccanning");
    // itemName = cs.getItemName();
    // itemDetails = cs.getDetails();

    // ignore: use_build_context_synchronously
    // Navigator.pushReplacementNamed(context, '/details', arguments: {
    //   'name': itemName!,
    //   'calories per serve': itemDetails["calories"]!,
    //   'carbohydrate per serve': itemDetails['carbohydrate']!,
    //   'protein per serve': itemDetails['protein']!,
    //   'fat per serve': itemDetails['fat']!,
    //   'saturated fat per serve': itemDetails['saturated']!,
    //   'salt per serve': itemDetails['salt']!,
    //   'sugar per serve': itemDetails['sugar']!,
    // });
    Navigator.pushReplacementNamed(context, '/loading');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Food'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30),
                const Text("Commonly added food:",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
                foodSuggestion("Banana", 100, 10, 10, 10),
                const SizedBox(height: 10),
                foodSuggestion("Banana", 100, 10, 10, 10),
                const SizedBox(height: 10),
                foodSuggestion("Banana", 100, 10, 10, 10),
                const SizedBox(height: 10),
                foodSuggestion("Banana", 100, 10, 10, 10),
                const SizedBox(height: 10),
                foodSuggestion("Banana", 100, 10, 10, 10),
                const SizedBox(height: 10),
                foodSuggestion("Banana", 100, 10, 10, 10),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                  child: ElevatedButton.icon(
                      style: elevatedButtonStyle(),
                      onPressed: () => scanBarCode(),
                      icon: const Icon(Icons.document_scanner_outlined),
                      label: const Text("Open barcode scanner")),
                ),
              ]),
        ),
      ),
    );
  }

  BoxDecoration boxdecor() {
    return BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(width: 2, color: Colors.grey),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ));
  }

  ButtonStyle elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(50),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    );
  }

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
