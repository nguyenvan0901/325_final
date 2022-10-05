import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Model/barcode_scanner.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String? itemName = "";
  var itemDetails = {};

  void loadScanData() async {
    CodeScanner cs = CodeScanner();
    await cs.openBarCodeScanner();
    itemName = cs.getItemName();
    itemDetails = cs.getDetails();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/details', arguments: {
      'name': itemName!,
      'calories per serve': itemDetails["calories"]!,
      'carbohydrate per serve': itemDetails['carbohydrate']!,
      'protein per serve': itemDetails['protein']!,
      'fat per serve': itemDetails['fat']!,
      'saturated fat per serve': itemDetails['saturated']!,
      'salt per serve': itemDetails['salt']!,
      'sugar per serve': itemDetails['sugar']!,
    });
  }

  @override
  void initState() {
    loadScanData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 80,
        ),
      ),
    );
  }
}
