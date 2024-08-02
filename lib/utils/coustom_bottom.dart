import 'package:flutter/material.dart';

Widget coustomBottom(
    {required VoidCallback onTap,
    required String text,
    required Color bgColor,
    required Color textColor}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
