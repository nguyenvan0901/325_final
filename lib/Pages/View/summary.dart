import 'package:flutter/material.dart';
import 'package:my_app/Pages/Model/firebase.dart';
import 'package:percent_indicator/percent_indicator.dart';

// This screen contains the daily nutriment summary in visualisations

class Summary extends StatefulWidget {
  const Summary({super.key});

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  FirebaseAction fa = FirebaseAction();
  String dateStr =
      "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";

  double percentageCalo = 0;
  double percentageCarb = 0;
  double percentageProtein = 0;
  double percentageFat = 0;

  double caloriesGoal = 3000;
  double proteinGoal = 140;
  double carbGoal = 400;
  double fatGoal = 95;

  double totalCalories = 0;
  double totalCarb = 0;
  double totalProtein = 0;
  double totalFat = 0;
  List<Entry> foodItems = [];

  // Initialse all the values of calories, carb, protein, fat and its percentage
  // compared to the goal.
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

    setState(() {
      percentageCalo = (totalCalories / caloriesGoal);
      percentageCarb = (totalCarb / carbGoal);
      percentageProtein = (totalProtein / proteinGoal);
      percentageFat = (totalFat / fatGoal);
    });
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
        title: const Text("Daily Summary"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: [
              const SizedBox(height: 20),
              const Text("Consumed Calories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              totalCaloDisplay(),
              const SizedBox(height: 10),
              Text("Goal: $caloriesGoal",
                  style: TextStyle(fontSize: 15, color: Colors.grey[500])),
              divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text("More details: ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                  displayNutriment("Carbohydrates", totalCarb, carbGoal,
                      percentageCarb, Colors.green, Colors.green.shade100),
                  displayNutriment(
                      "Protein",
                      totalProtein,
                      proteinGoal,
                      percentageProtein,
                      Colors.yellow.shade500,
                      Colors.yellow.shade100),
                  displayNutriment("Fat", totalFat, fatGoal, percentageFat,
                      Colors.orange, Colors.orange.shade100),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // This CircularPercentIndicator component
  // used to display the circle visualisation for calories.
  CircularPercentIndicator totalCaloDisplay() {
    return CircularPercentIndicator(
      animation: true,
      radius: 80,
      lineWidth: 12,
      percent: percentageCalo,
      progressColor: Colors.blue,
      backgroundColor: Colors.blue.shade100,
      circularStrokeCap: CircularStrokeCap.round,
      center: Text(totalCalories.toString(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Column displayNutriment(String category, double total, double goal,
      double percentage, Color progressColor, Color bgColor) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("$category : $total"),
            Text("Goal: $goal"),
          ],
        ),
      ),

      // This LinearPercentIndicator component
      // used to display the line visualisation for carb, protein, fat.
      LinearPercentIndicator(
        animation: true,
        lineHeight: 20,
        percent: percentage,
        progressColor: progressColor,
        backgroundColor: bgColor,
        barRadius: const Radius.circular(16),
      ),
      const SizedBox(height: 25),
    ]);
  }

  Divider divider() {
    return const Divider(
      color: Colors.grey,
      height: 20,
      thickness: 2,
      indent: 10,
      endIndent: 10,
    );
  }
}
