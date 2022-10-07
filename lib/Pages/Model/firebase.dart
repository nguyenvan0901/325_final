import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// This file contains all the functions that handle the logic of reading and 
// writting data from firebase.
class FirebaseAction {
  FirebaseAction();

  // This list contains all the food read/retrive from firebase.
  List<Entry> foodItems = [];

  // This function handles the logic in writting new entry to firebase.
  void addToDatabase(String name, double calories, double carbs, double protein,
      double fat) async {
    DateTime today = DateTime.now();
    String dateStr = "${today.day}-${today.month}-${today.year}";
    debugPrint(dateStr);
    // using the date in string format as th collection name
    final docUser = FirebaseFirestore.instance.collection(dateStr).doc();
    final json = {
      'name': name,
      'calories': calories,
      'carbohydrate': carbs,
      'protein': protein,
      'fat': fat,
    };
    await docUser.set(json);
    debugPrint("check firebase!");
  }

  // This function handles the logic behind reading the data from firebase
  Future<List<Entry>> retrieveDataOnDate(String date) async {
    var records = await FirebaseFirestore.instance.collection(date).get();
    List<Entry> items = records.docs
        .map((item) => Entry(
              name: item['name'],
              calories: item['calories'],
              carbs: item['carbohydrate'],
              protein: item['protein'],
              fat: item['fat'],
            ))
        .toList();

    foodItems.addAll(items);
    return foodItems;
  }
}

// This class is an instance that contains all the nutriment values of a food 
// read from firebase.
class Entry {
  String name = "unknown";
  double calories = 0;
  double carbs = 0;
  double protein = 0;
  double fat = 0;

  Entry({
    required this.name,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fat,
  });
}
