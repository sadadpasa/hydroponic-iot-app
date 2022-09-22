import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_style.dart';
import 'package:intl/intl.dart';

class HeaderBar extends StatefulWidget {
  const HeaderBar({Key? key}) : super(key: key);

  @override
  State<HeaderBar> createState() => _HeaderBarState();
}

class _HeaderBarState extends State<HeaderBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 15.0,
              offset: const Offset(0.0, 0.75))
        ],
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DateFormat("MMMM dd, yyyy").format(DateTime.now()),
              style: Styles.header4),
          const SizedBox(
            height: 10,
          ),
          Text('Hydroponeic App', style: Styles.header1),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.circle,
                color: Color(0xFF1BE08D),
                size: 15,
              ),
              const SizedBox(
                width: 7,
              ),
              Text("Sadad's Phone",
                  style: Styles.header4.copyWith(color: Styles.textColor)),
            ],
          ),
        ],
      ),
    );
  }
}
