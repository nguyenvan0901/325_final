import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// This screen displays the app settings.

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Color appbarColor = Colors.green;
  Color? backgroundColor = Colors.white;
  Color textColor = Colors.black;

  bool darkMode = false;
  bool light = false;
  double darknessLevel = 900.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Setting Screen"),
        backgroundColor: appbarColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 15, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // This code block is for displaying the meta data
              Text("Meta data:", style: getHeaderTextStyle()),
              nutrimentsTextField("Calories:", "3000"),
              const SizedBox(height: 10),
              nutrimentsTextField("Carbohydrate:", "400"),
              const SizedBox(height: 10),
              nutrimentsTextField("Protein:", "140"),
              const SizedBox(height: 10),
              nutrimentsTextField("Fat:", "95"),
              const SizedBox(height: 10),
              divider(),

              // This code block is for displaying the screen options
              Text("Screen Setting", style: getHeaderTextStyle()),
              darkmodeSwitch(),
              sliderDarkLevel(),
              divider(),

              // This code block is for displaying the save button
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                child: ElevatedButton.icon(
                    style: elevatedButtonStyle(),
                    onPressed: () {
                      
                    },
                    icon: const Icon(Icons.save_alt_outlined),
                    label: const Text("Save all changes")),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle getHeaderTextStyle() {
    return TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: textColor);
  }

  TextStyle getSubTextStyle() {
    return TextStyle(fontSize: 15, color: textColor);
  }

  Padding nutrimentsTextField(String category, String defaultValue) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(category, style: getSubTextStyle()),
          getInputTextField(defaultValue),
        ],
      ),
    );
  }

  SizedBox getInputTextField(String defaultValue) {
    return SizedBox(
      width: 80,
      height: 40,
      child: TextField(
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: defaultValue,
          hintStyle: TextStyle(color: textColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: textColor),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }

  Divider divider() {
    return Divider(
      color: Colors.grey[400],
      height: 20,
      thickness: 1,
      indent: 0,
      endIndent: 0,
    );
  }

  // Switch component
  Padding darkmodeSwitch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Dark mode", style: getSubTextStyle()),
          CupertinoSwitch(
            value: light,
            onChanged: (bool value) => {
              setState(() {
                //if dark mode set dark theme
                if (value) {
                  appbarColor = Colors.black;
                  backgroundColor = Colors.grey[900];
                  textColor = Colors.white;
                  light = value;
                  darkMode = true;
                } else {
                  appbarColor = Colors.green;
                  backgroundColor = Colors.white;
                  textColor = Colors.black;
                  light = value;
                  darkMode = false;
                }
              })
            },
          ),
        ],
      ),
    );
  }

  // Slider component
  Padding sliderDarkLevel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Darkness level", style: getSubTextStyle()),
          CupertinoSlider(
              value: darknessLevel,
              min: 400,
              max: 900,
              divisions: 5,
              onChanged: (value) {
                if (darkMode) {
                  setState(() {
                    darknessLevel = value;
                    backgroundColor = Colors.grey[value.toInt()];
                  });
                }
              })
        ],
      ),
    );
  }

  ButtonStyle elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        side: const BorderSide(width: 1, color: Colors.white));
  }
}
