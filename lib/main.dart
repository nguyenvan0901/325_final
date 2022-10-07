import 'package:flutter/material.dart';
import 'package:my_app/Pages/View/home.dart';
import 'package:firebase_core/firebase_core.dart';

// This is the welcome screen that user will see first when using the app.

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // SingleChildScrollView component
      body: SingleChildScrollView(
        // Center component
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 70, 20, 0),

            // Column component
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/foodsample.jpeg',
                  width: 400,
                  height: 350,
                ),
                const SizedBox(height: 30),
                const Text(
                  "Your personal",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text("DIET TRACKER",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    )),

                // SizedBox component
                const SizedBox(
                  height: 25,
                ),

                // Text component
                const Text(
                  "Tracking all the calories you eat, including nutritient" +
                      "such as carbohydrates, proteins, fat, sugar, salt,...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),

                // MaterialButton component
                MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  minWidth: double.infinity,
                  height: 40,
                  color: Colors.green,
                  textColor: Colors.white,
                  child:
                      const Text('GET STARTED', style: TextStyle(fontSize: 15)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
