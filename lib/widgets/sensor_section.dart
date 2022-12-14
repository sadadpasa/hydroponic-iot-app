import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_style.dart';
import 'package:flutter_app/widgets/sensor_bar.dart';

class SensorSection extends StatefulWidget {
  const SensorSection({Key? key}) : super(key: key);

  @override
  State<SensorSection> createState() => _SensorSectionState();
}

class _SensorSectionState extends State<SensorSection> {
  DatabaseReference ref = FirebaseDatabase.instance.ref('plantId');
  List<String> plantList = ["Kangkung", "Kol", "Pakcoy"];
  // var plantData = [
  //   {'id': 0, 'name': 'Kangkung'},
  //   {'id': 1, 'name': 'Kol'},
  //   {'id': 2, 'name': 'Pakcoy'},
  // ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<DatabaseEvent>(
            future: ref.once(),
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownSearch<String>(
                  popupProps: PopupProps.modalBottomSheet(
                      showSelectedItems: true, textStyle: Styles.header1),
                  items: plantList,
                  selectedItem: snapshot.connectionState == ConnectionState.done
                      ? plantList[(snapshot.data!.snapshot.value as int) - 1]
                      : 'Loading...',
                  onChanged: (value) {
                    ref.set(plantList.indexOf(value ?? '') + 1);
                  },
                  dropdownButtonProps:
                      DropdownButtonProps(color: Styles.primaryColor),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                          labelText: "Pilih tanaman Kamu disini",
                          prefixText: 'Kamu sedang menanam : ',
                          labelStyle: const TextStyle(color: Colors.black),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(
                                color: Colors.white, width: 0.0),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Styles.primaryColor, width: 0.0),
                            borderRadius: BorderRadius.circular(15),
                          ))),
                ),
              );
            }),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SensorBar(
                title: 'Temperature',
                path: "sensor/temp",
                icon: Icons.home,
                suffixTitle: '??C',
              ),
              SensorBar(title: 'pH', path: "sensor/ph", icon: Icons.home),
              SensorBar(
                  title: 'Nutrition', path: "sensor/tds", icon: Icons.home)
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
