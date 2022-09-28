import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../utils/app_style.dart';

class ControllerBar extends StatefulWidget {
  final bool manualState;
  final String path;
  final String title;
  final IconData icon;
  const ControllerBar({
    Key? key,
    required this.manualState,
    required this.path,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  State<ControllerBar> createState() => _ControllerBarState();
}

class _ControllerBarState extends State<ControllerBar> {
  late DatabaseReference ref = FirebaseDatabase.instance.ref(widget.path);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
        stream: ref.onValue,
        builder: (context, snapshot) {
          bool switchState = snapshot.data?.snapshot.value.toString() == 'true';
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
                color: switchState
                    ? (widget.manualState
                        ? Styles.primaryColor
                        : Styles.primaryColor
                            .withOpacity(Styles.disabledColorOp))
                    : (widget.manualState
                        ? Colors.white
                        : Colors.white.withOpacity(Styles.disabledColorOp)),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Styles.primaryColor.withOpacity(0.2),
                      offset: const Offset(0, 8),
                      blurRadius: 24,
                      spreadRadius: 0)
                ]),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(widget.icon,
                          color: switchState
                              ? (widget.manualState
                                  ? Colors.white
                                  : Colors.white
                                      .withOpacity(Styles.disabledColorOp))
                              : (widget.manualState
                                  ? const Color(0xFF6F7EA8)
                                  : const Color(0xFF6F7EA8)
                                      .withOpacity(Styles.disabledColorOp))),
                      const SizedBox(width: 45),
                      Text(
                        widget.title,
                        style: Styles.header3.copyWith(
                            color: switchState
                                ? (widget.manualState
                                    ? Colors.white
                                    : Colors.white
                                        .withOpacity(Styles.disabledColorOp))
                                : (widget.manualState
                                    ? const Color(0xFF6F7EA8)
                                    : const Color(0xFF6F7EA8)
                                        .withOpacity(Styles.disabledColorOp))),
                      ),
                    ],
                  ),
                  Switch(
                    value: switchState,
                    onChanged: (bool value) {
                      if (widget.manualState) {
                        ref.set(value);
                      }
                    },
                    activeColor: widget.manualState
                        ? Colors.white
                        : Colors.white.withOpacity(Styles.disabledColorOp),
                    inactiveTrackColor: widget.manualState
                        ? Styles.bgColor
                        : Styles.bgColor.withOpacity(Styles.disabledColorOp),
                    inactiveThumbColor: widget.manualState
                        ? Styles.primaryColor
                        : Styles.primaryColor
                            .withOpacity(Styles.disabledColorOp),
                  )
                ]),
          );
        });
  }
}
