// This screen shows the detai

import 'package:flutter/material.dart';
import 'package:my_app/Pages/Model/barcode_scanner.dart';
import 'package:my_app/Pages/Model/firebase.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  FirebaseAction fa = FirebaseAction();
  CodeScanner cs = CodeScanner();

  var data = {};
  double serving = 100.0;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;

    String name = data['name'];

    double calories = (data['calories per serve'] / 4) / 100 * serving;
    double carb = (data['carbohydrate per serve']) / 100 * serving;
    double protein = (data['protein per serve']) / 100 * serving;
    double fat = (data['fat per serve']) / 100 * serving;
    double saturated = data['saturated fat per serve'] / 100 * serving;
    double salt = data['salt per serve'] / 100 * serving;
    double sugar = data['sugar per serve'] / 100 * serving;

    calories = double.parse((calories).toStringAsFixed(2));
    carb = double.parse((carb).toStringAsFixed(2));
    protein = double.parse((protein).toStringAsFixed(2));
    fat = double.parse((fat).toStringAsFixed(2));
    saturated = double.parse((saturated).toStringAsFixed(2));
    salt = double.parse((salt).toStringAsFixed(2));
    sugar = double.parse((sugar).toStringAsFixed(2));

    int carbsPercentage = ((carb * 4 / calories) * 100).round();
    int proteinsPercentage = ((protein * 4 / calories) * 100).round();
    int fatsPercentage = (100 - carbsPercentage - proteinsPercentage);

    void changeValues(String text) {
      double? number = double.tryParse(text);
      if (number != null && number > 0) {
        double number = double.parse(text);
        setState(() => {serving = number});
      }
    }

    void addToDatabase(String name, double calories, double carbs,
        double protein, double fat) async {
      fa.addToDatabase(name, calories, carbs, protein, fat);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Details"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.grey[300],
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Text("Based on the barcode, your food is:  $name",
                  style: TextStyle(fontSize: 12, color: Colors.grey[500])),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            divider(),
            const SizedBox(height: 20),

            // Displaying total calories in circle
            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Text("$calories",
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                      const SizedBox(height: 2),
                      const Text("CALORIES", style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Displaying percentage, category, amount of each nutriment
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    displayPercentage(carbsPercentage),
                    displayPercentage(proteinsPercentage),
                    displayPercentage(fatsPercentage),
                  ]),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("CARBS", style: nutrimentCategoryTs()),
                    Text("PROTEIN", style: nutrimentCategoryTs()),
                    Text("FATS", style: nutrimentCategoryTs()),
                  ]),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 20, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    displayNutrimentValue(carb),
                    displayNutrimentValue(protein),
                    displayNutrimentValue(fat),
                  ]),
            ),
            const SizedBox(height: 20),

            // Display serving sizes

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text("Number of servings: ",
                      style: TextStyle(fontSize: 15)),
                  SizedBox(
                    width: 80,
                    height: 40,
                    child: TextField(
                      textAlign: TextAlign.right,
                      decoration: const InputDecoration(
                        hintText: "100g",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onChanged: (text) => {
                        setState(() {
                          changeValues(text);
                        })
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            divider(),

            // Displaying 2 buttons for users to either exit or save food
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(children: <Widget>[
                ElevatedButton.icon(
                    style: elevatedButtonStyle(),
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/'),
                    icon: const Icon(Icons.document_scanner_outlined),
                    label: const Text("Rescan")),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                    style: elevatedButtonStyle(),
                    onPressed: () => {
                          addToDatabase(name, calories, carb, protein, fat),
                          Navigator.pushReplacementNamed(context, '/'),
                        },
                    icon: const Icon(Icons.save_alt_outlined),
                    label: const Text("Save Food"))
              ]),
            ),
          ],
        ),
      ),
    );
  }

  ButtonStyle elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(50),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    );
  }

  Divider divider() {
    return const Divider(
      color: Colors.grey,
      height: 20,
      thickness: 1,
      indent: 10,
      endIndent: 10,
    );
  }

  Text displayPercentage(int percentage) {
    return Text("$percentage%",
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green));
  }

  TextStyle nutrimentCategoryTs() {
    return const TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green);
  }

  Text displayNutrimentValue(double value) {
    return Text("$value g",
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold));
  }
}
