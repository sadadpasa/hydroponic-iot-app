import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_style.dart';
import 'package:flutter_app/widgets/controller_bar.dart';

class ControllerSection extends StatefulWidget {
  const ControllerSection({Key? key}) : super(key: key);

  @override
  State<ControllerSection> createState() => _ControllerSectionState();
}

class _ControllerSectionState extends State<ControllerSection> {
  DatabaseReference modeRef = FirebaseDatabase.instance.ref("manual");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
        stream: modeRef.onValue,
        builder: (context, snapshot) {
          bool manualState = snapshot.data?.snapshot.value.toString() == 'true';
          var selectedMode = [manualState, !manualState];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: Text('Mode',
                    style: Styles.header3.copyWith(
                        color: Styles.primaryColor,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ToggleButtons(
                  color: Styles.primaryColor,
                  selectedColor: Colors.white,
                  borderColor: Styles.primaryColor,
                  selectedBorderColor: Styles.primaryColor,
                  fillColor: Styles.primaryColor,
                  splashColor: Styles.primaryColor.withOpacity(0.12),
                  hoverColor: Styles.primaryColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(10),
                  constraints: BoxConstraints(
                      minHeight: 32.0,
                      minWidth: MediaQuery.of(context).size.width / 2 - 20),
                  isSelected: selectedMode,
                  onPressed: (index) {
                    // Respond to button selection
                    setState(() {
                      index == 0 ? modeRef.set(true) : modeRef.set(false);
                    });
                  },
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Manual'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Auto'),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ControllerBar(
                manualState: manualState,
                path: "state/ph-up",
                title: 'pH up',
                icon: Icons.arrow_upward,
              ),
              const SizedBox(height: 20),
              ControllerBar(
                  manualState: manualState,
                  path: "state/ph-down",
                  title: 'pH down',
                  icon: Icons.arrow_downward),
              const SizedBox(height: 20),
              ControllerBar(
                  manualState: manualState,
                  path: "state/tds",
                  title: "Nutrient Pump",
                  icon: Icons.water_drop),
              const SizedBox(height: 30),
            ],
          );
        });
  }
}
