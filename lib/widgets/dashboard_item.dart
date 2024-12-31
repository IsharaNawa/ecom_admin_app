import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  const DashboardItem({super.key, required this.name, required this.btn_icon});

  final String name;
  final IconData btn_icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: 100,
      width: size.width / 2,
      child: Column(
        children: [
          Icon(btn_icon),
          Text(name),
        ],
      ),
    );
  }
}
