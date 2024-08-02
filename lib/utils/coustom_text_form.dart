import 'package:flutter/material.dart';

class CoustomTextForm extends StatelessWidget {
  CoustomTextForm(
      {super.key,
      this.prefIcon,
      this.prefIconColor,
      this.suffixIcone,
      this.onChange,
      this.validator,
      this.onSubmitt,
      this.controller,
      this.textStyle,
      this.suffixIconeColor,
      required this.passwordText,
      required this.label,
      required this.text,
      required this.museTextColor,
      required this.borderColor,
      required this.borderReduse,
      required this.labelColor,
      required this.userTextColor});

  Color userTextColor;
  Color museTextColor;
  bool passwordText;
  double? textStyle;
  Color? prefIconColor;
  Color? suffixIconeColor;
  Color labelColor;
  Color borderColor;
  double borderReduse;
  TextEditingController? controller;
  Function(String)? onChange;
  FormFieldValidator<String>? validator;
  Function(String)? onSubmitt;
  IconData? prefIcon;
  IconButton? suffixIcone;
  TextInputType text;
  String label;

  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onFieldSubmitted: onSubmitt,
      onChanged: onChange,
      obscureText: passwordText,
      style: TextStyle(color: userTextColor, fontSize: textStyle),
      cursorColor: museTextColor,
      keyboardType: text,
      decoration: InputDecoration(
          suffixIcon: suffixIcone,
          suffixIconColor: suffixIconeColor,
          prefixIconColor: prefIconColor,
          prefixIcon: Icon(prefIcon),
          labelText: label,
          //obscureText: passwordText,
          labelStyle: TextStyle(color: labelColor),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderReduse),
              borderSide: BorderSide(color: borderColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderReduse),
              borderSide: BorderSide(color: borderColor)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(borderReduse))),
    );
  }
}

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {},
      child: Text(
        text.toUpperCase(),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (route) {
      return false;
    });
