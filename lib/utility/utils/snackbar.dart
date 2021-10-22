import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showSnackBar(BuildContext context,
    {required String msg, Color? bgColor, int? durationInSeconds}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    backgroundColor: bgColor ?? Colors.red,
    duration: Duration(seconds: durationInSeconds ?? 3),
  ));
}
