// This screen will show all items that have been searched by users
// This includes photo, item name, calories, similar categories.

import 'package:flutter/material.dart';
import 'package:my_app/Pages/Model/firebase.dart';

class Record extends StatefulWidget {
  const Record({super.key});

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  FirebaseAction fa = FirebaseAction();
  DateTime now = DateTime.now();

  String dateStr =
      "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
  double totalCalories = 0;
  double totalCarb = 0;
  double totalProtein = 0;
  double totalFat = 0;
  double totalSatFat = 0;
  double sugar = 0;
  double salt = 0;
  List<Entry> foodItems = [];

  // This method is used to retrive data from the firebase
  Future<void> initialiseNutriments() async {
    List<Entry> items = await fa.retrieveDataOnDate(dateStr);
    setState(() {
      foodItems.clear();
      foodItems.addAll(items);
    });

    for (int i = 0; i < foodItems.length; i++) {
      totalCalories = totalCalories + foodItems[i].calories;
      totalCarb = totalCarb + foodItems[i].carbs;
      totalProtein = totalProtein + foodItems[i].protein;
      totalFat = totalFat + foodItems[i].fat;
    }

    // rounding numbers to 2dp
    totalCalories = double.parse((totalCalories).toStringAsFixed(2));
    totalCarb = double.parse((totalCarb).toStringAsFixed(2));
    totalProtein = double.parse((totalProtein).toStringAsFixed(2));
    totalFat = double.parse((totalFat).toStringAsFixed(2));
  }

  @override
  void initState() {
    super.initState();
    initialiseNutriments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Record Screen"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () => previousDay(),
                      child: const Icon(Icons.chevron_left_outlined)),
                  Text(dateStr,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () => nextDay(),
                      child: const Icon(Icons.chevron_right_outlined)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
                children:
                    foodItems.map((item) => buildItemInfo(item)).toList()),
            const SizedBox(height: 10),
            buildSummaryDetails(),
          ],
        ),
      ),
    );
  }

  Widget buildSummaryDetails() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5.0),
      decoration: boxdecor(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Nutriment Summary", style: textstyle()),
              Text("Total", style: textstyle()),
            ],
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nutrimentDisplay("Calories:", totalCalories),
                nutrimentDisplay("Carbohydrate:", totalCarb),
                nutrimentDisplay("Protein:", totalProtein),
                nutrimentDisplay("Fat:", totalFat),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItemInfo(Entry item) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5.0),
      decoration: boxdecor(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(item.name, style: textstyle()),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nutrimentDisplay("Calories", item.calories),
                nutrimentDisplay("Carbohydrate", item.carbs),
                nutrimentDisplay("Protein", item.protein),
                nutrimentDisplay("Fat", item.fat),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget nutrimentDisplay(String nutrimentCategory, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(nutrimentCategory),
        Text("$value"),
      ],
    );
  }

  // This method returns a BoxDecoration object to round boxes coners and
  // draw it in black.
  BoxDecoration boxdecor() {
    return BoxDecoration(
        border: Border.all(width: 2),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ));
  }

  // Text style for displaying the header of each food box.
  TextStyle textstyle() {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
  }

  // Text style for the 2 indication to navigate between days.
  TextStyle textStyleIndicator() {
    return const TextStyle(
        fontSize: 30, fontWeight: FontWeight.bold, color: Colors.grey);
  }

  ElevatedButton createButton(Icon icon) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        onPressed: () {},
        child: icon);
  }

  void previousDay() async {
    DateTime yesterday = now.subtract(const Duration(days: 1));
    dateStr = "${yesterday.day}-${yesterday.month}-${yesterday.year}";
    FirebaseAction newFa = FirebaseAction();

    List<Entry> newList = await newFa.retrieveDataOnDate(dateStr);

    double totalCaloriesNew = 0;
    double totalCarbNew = 0;
    double totalProteinNew = 0;
    double totalFatNew = 0;

    for (int i = 0; i < newList.length; i++) {
      totalCaloriesNew = totalCaloriesNew + newList[i].calories;
      totalCarbNew = totalCarbNew + newList[i].carbs;
      totalProteinNew = totalProteinNew + newList[i].protein;
      totalFatNew = totalFatNew + newList[i].fat;
    }

    // rounding numbers to 2dp
    totalCaloriesNew = double.parse((totalCaloriesNew).toStringAsFixed(2));
    totalCarbNew = double.parse((totalCarbNew).toStringAsFixed(2));
    totalProteinNew = double.parse((totalProteinNew).toStringAsFixed(2));
    totalFatNew = double.parse((totalFatNew).toStringAsFixed(2));

    setState(() {
      now = yesterday;
      dateStr = "${yesterday.day}-${yesterday.month}-${yesterday.year}";
      foodItems.clear();
      foodItems.addAll(newList);
      totalCalories = totalCaloriesNew;
      totalCarb = totalCarbNew;
      totalProtein = totalProteinNew;
      totalFat = totalFatNew;
    });
  }

  void nextDay() async {
    DateTime tomorrow = now.subtract(const Duration(days: -1));
    dateStr = "${tomorrow.day}-${tomorrow.month}-${tomorrow.year}";
    FirebaseAction newFa = FirebaseAction();

    List<Entry> newList = await newFa.retrieveDataOnDate(dateStr);

    double totalCaloriesNew = 0;
    double totalCarbNew = 0;
    double totalProteinNew = 0;
    double totalFatNew = 0;

    for (int i = 0; i < newList.length; i++) {
      totalCaloriesNew = totalCaloriesNew + newList[i].calories;
      totalCarbNew = totalCarbNew + newList[i].carbs;
      totalProteinNew = totalProteinNew + newList[i].protein;
      totalFatNew = totalFatNew + newList[i].fat;
    }

    // rounding numbers to 2dp
    totalCaloriesNew = double.parse((totalCaloriesNew).toStringAsFixed(2));
    totalCarbNew = double.parse((totalCarbNew).toStringAsFixed(2));
    totalProteinNew = double.parse((totalProteinNew).toStringAsFixed(2));
    totalFatNew = double.parse((totalFatNew).toStringAsFixed(2));

    setState(() {
      now = tomorrow;
      dateStr = "${tomorrow.day}-${tomorrow.month}-${tomorrow.year}";
      foodItems.clear();
      foodItems.addAll(newList);
      totalCalories = totalCaloriesNew;
      totalCarb = totalCarbNew;
      totalProtein = totalProteinNew;
      totalFat = totalFatNew;
    });
  }
}
