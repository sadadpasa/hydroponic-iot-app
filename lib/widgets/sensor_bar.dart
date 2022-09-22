import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../utils/app_style.dart';

class SensorBar extends StatefulWidget {
  final String title;
  final String path;
  final IconData icon;
  final String? suffixTitle;
  const SensorBar(
      {Key? key,
      required this.title,
      required this.path,
      required this.icon,
      this.suffixTitle = ''})
      : super(key: key);

  @override
  State<SensorBar> createState() => _SensorBarState();
}

class _SensorBarState extends State<SensorBar> {
  late DatabaseReference ref = FirebaseDatabase.instance.ref(widget.path);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
        stream: ref.onValue,
        builder: (context, snapshot) {
          return Container(
            decoration: BoxDecoration(
                color: Styles.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Styles.primaryColor.withOpacity(0.3),
                      offset: const Offset(0, 8),
                      blurRadius: 24,
                      spreadRadius: 0)
                ]),
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width / 3.8,
            height: 125,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  widget.icon,
                  color: Colors.white,
                  size: 20,
                ),
                Center(
                  child: Text(
                    "${snapshot.data?.snapshot.value.toString() ?? '0'}${widget.suffixTitle}",
                    style: Styles.header2.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
                Center(
                  child: Text(
                    widget.title,
                    style: Styles.textStyle.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
